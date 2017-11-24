//
//  PhotoNet.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Alamofire

class PhotoNet {
    
    private init() {}
    
    class func add(photo: Photo, completion: @escaping (Photo?, Error?) -> Void) {
        let dic = buildDictionary(fromPhoto: photo)
        
        Alamofire.request(R.photosDomain, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error!)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "photo")!
            let photo = buildPhoto(fromDictionary: dic)
            
            completion(photo, nil)
        }
    }
    
    class func getAll(completion: @escaping ([Photo]?, Error?) -> Void) {
        
        Alamofire.request(R.photosDomain).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "photos")!
            let photos = buildPhotos(fromDictionaryArry: arr)
            
            completion(photos, nil)
        }
    }
    
    class func get(byToken token: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        let completeDomain = R.challengesDomain + "/me"
        let header = ["x-auth" : token]
        
        Alamofire.request(completeDomain, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "photos")!
            let photos = buildPhotos(fromDictionaryArry: arr)
            
            completion(photos, nil)
        }
    }
    
    class func get(byChallengeId id: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        let completeDomain = R.challengesDomain + "/\(id)"
        
        Alamofire.request(completeDomain).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "photos")!
            let photos = buildPhotos(fromDictionaryArry: arr)
            
            completion(photos, nil)
        }
    }
    
    class func buildPhotos(fromDictionaryArry a: [[String: Any]]) -> [Photo] {
        
        return a.map { dic -> Photo in
        
            return buildPhoto(fromDictionary: dic)
        }
    }
    
    class func buildPhoto(fromDictionary d: [String: Any]) -> Photo {
        
        let id = d["_id"] as! String
        let url = d["url"] as! String
        let ownerId = d["_owner"] as! String
        let challengeId = d["_challenge"] as! String
        
        return Photo(id, url, ownerId, challengeId)
    }
    
    class func buildDictionary(fromPhoto p: Photo) -> [String: Any] {
        
        return ["_id": p.id ?? "",
                "url": p.url!,
                "_owner": p.ownerId,
                "_challenge": p.challengeId]
    }
}

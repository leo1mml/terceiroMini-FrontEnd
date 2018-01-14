//
//  PhotoNet.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Alamofire

/**
 
 This class manages the web service/app photos data flow. It must be used without instanciating the class.
 */
class PhotoNet {
    
    private init() {}
    
    // MARK: - Web Service methods
    
    /**
     
     Adds a new photo to the database.
     
     - parameter photo: The photo to be saved.
     - parameter compeltion: A block of code to be executed once the task is complete.
     - parameter p: The photo that has being saved.
     - parameter e: The error that ocurred.
     */
    class func add(photo: Photo, completion: @escaping (_ p: Photo?,_ e: Error?) -> Void) {
        let dic = buildDictionary(fromPhoto: photo)
        
        Alamofire.request(R.photosDomain, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "photo")!
            let photo = buildPhoto(fromDictionary: dic)
            
            completion(photo, nil)
        }
    }
   
    
    /**
     
     Gets the data of all the photos in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter p: The photos retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func getAll(completion: @escaping (_ p: [Photo]?, _ e: Error?) -> Void) {
        
        Alamofire.request(R.photosDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "photos")!
            let photos = buildPhotos(fromDictionaryArry: arr)
            
            completion(photos, nil)
        }
    }
    
    /**
     
     Get the data of all the photos of an user from the user token.
     
     - parameter token: The user comunication token.
     - parameter p: The photos retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func get(byToken token: String, completion: @escaping (_ p: [Photo]?, _ e: Error?) -> Void) {
        let completeDomain = R.photosDomain + "/me"
        let header = ["x-auth" : token]
        
        Alamofire.request(completeDomain, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "photos")!
            let photos = buildPhotos(fromDictionaryArry: arr)
            
            completion(photos, nil)
        }
    }
    
    /**
     
     Get the data of all the photos of an user from the user id.
     
     - parameter token: The user id.
     - parameter p: The photos retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func get(byUserId id: String, completion: @escaping (_ p: [Photo]?, _ e: Error?) -> Void) {
        let completeDomain = R.photosDomain + "/getPhotosByUserId/\(id)"
        
        Alamofire.request(completeDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "photos")!
            let photos = buildPhotos(fromDictionaryArry: arr)
            
            completion(photos, nil)
        }
    }
    
    /**
     
     Gets the data of all the photos of a challenge from its id.
     
     - parameter id: The challenge id.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter p: The photos retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func get(byChallengeId id: String, completion: @escaping (_ p: [Photo]?, _ e: Error?) -> Void) {
        let completeDomain = R.photosDomain + "/challenge/\(id)"
        
        Alamofire.request(completeDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "photos")!
            let photos = buildPhotos(fromDictionaryArry: arr)
            
            completion(photos, nil)
        }
    }
    
    /**
     
     Gets a photo by its id.
     
     - parameter id: The photo id.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter p: The photo retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func get(byId id: String, completion: @escaping (_ p: Photo?, _ e: Error?) -> Void) {
        let completeDomain = R.photosDomain + "/getById/\(id)"
        
        Alamofire.request(completeDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "photo")!
            let photo = buildPhoto(fromDictionary: dic)
            
            completion(photo, nil)
        }
    }
    
    /**
     
     Deletes a photo by its id.
     
     - parameter id: The photo id.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter p: The photo that has being deleted.
     - parameter e: The error that ocurred.
     */
    class func delete(byId id: String, completion: @escaping (_ p: Photo?, _ e: Error?) -> Void) {
        let completeDomain = R.photosDomain + "/deleteById/\(id)"
        
        Alamofire.request(completeDomain, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "photo")!
            let photo = buildPhoto(fromDictionary: dic)
            
            completion(photo, nil)
        }
    }
    
    
    /**

     Gets the data of a photo from challenge id (owner) and user token.
     
     - parameter id: The user id and token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter p: The photos retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func getMyClick(byChallengeId id: String, token: String, completion: @escaping (_ p: Photo?, _ e: Error?) -> Void) {
        
         //GET MY CLICK ID
        let completeDomain = R.photosDomain + "/getMyClick/\(id)"
        let header = ["x-auth": token]
        
        Alamofire.request(completeDomain, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) in
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            if let dic = NetHelper.extractDictionary(fromJson: val, key: "photo") {
                let photo = buildPhoto(fromDictionary: dic)
                completion(photo, nil)
                return
            }
            completion(nil, nil)
        }
        

    }
    
    /**
     
     Gets the data of a photo from challenge id and user token.
     
     - parameter id: The user id and token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter p: The photos retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func getMyFavouriteClick(byChallengeId id: String, token: String, completion: @escaping (_ p: Photo?, _ e: Error?) -> Void) {
        
        //GET MY CLICK ID
        let completeDomain = R.photosDomain + "/getMyFavouriteClick/\(id)"
        let header = ["x-auth": token]
        
        Alamofire.request(completeDomain, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) in
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "photo")!
            let photo = buildPhoto(fromDictionary: dic)
            
            
            completion(photo, nil)
        }
        
        
    }
    
    
    
    /**
     
     Registers a new vote for a photo.
     
     - parameter id: The id of the photo that you want to vote in.
     - parameter token: The server authentication token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter s: A boolean flag indicating if the task was completed successfully.
     */
    class func vote(byId id: String, token: String, completion: @escaping (_ s: Bool) -> Void) {
        let domain = R.photosDomain + "/vote/\(id)"
        let header = ["x-auth": token]
        
        Alamofire.request(domain, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().response { (response) in
            if(response.error != nil){
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    /**
     
     Unvotes a photo that is already voted.
     
     - parameter id: The id of the photo that you want to unvote.
     - parameter token: The server authentication token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter s: A boolean flag indicating if the task was completed successfully.
     */
    class func unvote(byId id: String, token: String, completion: @escaping (_ s: Bool) -> Void) {
        let domain = R.photosDomain + "/unvote/\(id)"
        let header = ["x-auth": token]
        
        Alamofire.request(domain, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().response { (response) in
            if(response.error != nil){
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    // MARK: - Auxiliar methods
    
    /**
     
     Creates a new array of photos from an array of dictionaries.
     
     - parameter arr: A dictionary array.
     */
    private class func buildPhotos(fromDictionaryArry arr: [[String: Any]]) -> [Photo] {
        
        return arr.map { dic -> Photo in
        
            return buildPhoto(fromDictionary: dic)
        }
    }
    
    /**
     
     Creates a new instance of a photo from a dictionary.
     
     - parameter dic: A dictionary.
     */
    private class func buildPhoto(fromDictionary dic: [String: Any]) -> Photo {
        
        let id = dic["_id"] as! String
        let url = dic["url"] as! String
        let ownerId = dic["_owner"] as! String
        let challengeId = dic["_challenge"] as! String
        let votes = dic["votes"] as! [String]
        
        return Photo(id, url, ownerId, challengeId, votes)
    }
    
    /**
     
     Creates a new dictionary from the photo data.
     
     - parameter photo: The photo data.
     */
    private class func buildDictionary(fromPhoto photo: Photo) -> [String: Any] {
        
        return ["_id": photo.id ?? "",
                "url": photo.url!,
                "_owner": photo.ownerId,
                "_challenge": photo.challengeId,
                "votes": photo.votes ?? []]
    }
}

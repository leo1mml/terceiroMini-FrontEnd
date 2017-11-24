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

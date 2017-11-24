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
    
    class func buildPhotos(fromDictionaryArry a: [[String: Any]]) -> [Photo] {
        
        return a.map { dic -> Photo in
        
            return buildPhoto(fromDictionary: dic)
        }
    }
    
    class func buildPhoto(fromDictionary d: [String: Any]) -> Photo {
        return Photo(url: "", ownerId: "", challengeId: "")
    }
    
    class func buildDictionary(fromPhoto p: Photo) -> [String: Any] {
        return ["_id": p.id ?? "", "url": p.url!, "_owner": p.ownerId, "_challenge": p.challengeId]
    }
}

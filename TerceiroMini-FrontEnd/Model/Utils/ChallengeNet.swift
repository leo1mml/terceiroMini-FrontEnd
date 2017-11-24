//
//  ChallengeNet.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Alamofire

class ChallengeNet {
    
    private init() {}
    
    class func getAll(completion: @escaping ([Challenge]?, Error?) -> Void) {
        
        Alamofire.request(R.challengesDomain).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error!)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "challenges")!
            let clg = buildChallenges(fromDictionaryArray: arr)
            
            completion(clg, nil)
        }
    }
    
    class func buildChallenges(fromDictionaryArray a: [[String: Any]]) -> [Challenge] {
        
        return a.map { dic -> Challenge in
            
            return buildChallenge(fromDictionary: dic)
        }
    }
    
    class func buildChallenge(fromDictionary d: [String: Any]) -> Challenge {
        
        let id = d["_id"] as! String
        let theme = d["theme"] as! String
        let startDate = d["startDate"] as! Date
        let endDate = d["endDate"] as! Date
        
        return Challenge(id, theme, startDate, endDate)
    }
}

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
    
    class func getAll(completion: @escaping ([Challenge]?, Error?) -> Void) {
        
    }
    
    class func buildChallenges(fromDictionaryArray a: [[String: Any]]) -> [Challenge] {
        
        return a.map { dic -> Challenge in
            
            return buildChallenge(fromDictionary: dic)
        }
    }
    
    class func buildChallenge(fromDictionary d: [String: Any]) -> Challenge {
        return Challenge(id: "", theme: "", startDate: Date(), endDate: Date())
    }
}

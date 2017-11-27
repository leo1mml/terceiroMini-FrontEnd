//
//  ChallengeNet.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Alamofire

/**
 
 This class manages the web service/app challenges data flow. It must be used without instanciating the class.
 */
class ChallengeNet {
    
    private init() {}
    
    /**
     
     Gets the data of all the challenges in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter challenges: The challenges retrieved by the task.
     - parameter error: The error that ocurred.
     */
    class func getAll(completion: @escaping (_ challenges: [Challenge]?, _ error: Error?) -> Void) {
        
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
    
    /**
     
     Creates an array of challenge from a dictionary array.
     
     - parameter a: A dictionary array.
     */
    class func buildChallenges(fromDictionaryArray a: [[String: Any]]) -> [Challenge] {
        
        return a.map { dic -> Challenge in
            
            return buildChallenge(fromDictionary: dic)
        }
    }
    
    /**
     
     Creates a new instace of challenge from a dictionary.
     
     - parameter d: A dictionary.
     */
    class func buildChallenge(fromDictionary d: [String: Any]) -> Challenge {
        
        let id = d["_id"] as! String
        let theme = d["theme"] as! String
        let startDate = d["startDate"] as! Date
        let endDate = d["endDate"] as! Date
        
        return Challenge(id, theme, startDate, endDate)
    }
}

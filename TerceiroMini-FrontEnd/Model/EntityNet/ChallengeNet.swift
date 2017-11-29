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
    
    // MARK: - Web Service methods
    
    /**
     
     Gets the data of all the challenges in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter c: The challenges retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func getAll(completion: @escaping (_ c: [Challenge]?, _ e: Error?) -> Void) {
        
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
    
    // MARK: - Auxiliar methods
    
    /**
     
     Creates an array of challenge from a dictionary array.
     
     - parameter arr: A dictionary array.
     */
    class func buildChallenges(fromDictionaryArray arr: [[String: Any]]) -> [Challenge] {
        
        return arr.map { dic -> Challenge in
            
            return buildChallenge(fromDictionary: dic)
        }
    }
    
    /**
     
     Creates a new instace of challenge from a dictionary.
     
     - parameter dic: A dictionary.
     */
    class func buildChallenge(fromDictionary dic: [String: Any]) -> Challenge {
        
        let id = dic["_id"] as! String
        let theme = dic["theme"] as! String
        let startDate = dic["startDate"] as! Date
        let endDate = dic["endDate"] as! Date
        
        return Challenge(id, theme, startDate, endDate)
    }
}

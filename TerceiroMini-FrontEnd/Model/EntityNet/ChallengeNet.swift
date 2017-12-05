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
        
        Alamofire.request(R.challengesDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "challenges")!
            let clg = buildChallenges(fromDictionaryArray: arr)
            
            completion(clg, nil)
        }
    }
    
    /**
     
     Gets the data of all the challenges in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter c: The challenges retrieved by the task.
     - parameter e: The error that ocurred.
     */
    
    class func getLastChallenges(completion: @escaping (_ c: [Challenge]?, _ e: Error?) -> Void) {
        
        Alamofire.request(R.challengesDomain + "/lastChallenges").validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "challengesPast")!
            let clg = buildChallenges(fromDictionaryArray: arr)
            
            completion(clg, nil)
        }
    }
    
    /**
     
     Gets the data of the incoming challenges in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter c: The challenges retrieved by the task.
     - parameter e: The error that ocurred.
     */
    
    class func getComingSoonChallenges(completion: @escaping (_ c: [Challenge]?, _ e: Error?) -> Void) {
        
        Alamofire.request(R.challengesDomain + "/comingSoonChallenges").validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "fourChallenges")!
            let clg = buildChallenges(fromDictionaryArray: arr)
            
            completion(clg, nil)
        }
    }
    /**
     
     Gets the data of the open challenges in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter c: The challenges retrieved by the task.
     - parameter e: The error that ocurred.
     */
    
    class func getOpenChallenges(completion: @escaping (_ c: [Challenge]?, _ e: Error?) -> Void) {
        
        Alamofire.request(R.challengesDomain + "/openChallenges").validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
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
        let imageUrl = dic["imageUrl"] as! String
        
        let startDateString = dic["startDate"] as! String
        let endDateString = dic["endDate"] as! String
        
        let startDate = DateHelper.shared.getDate(fromString: startDateString)!
        let endDate = DateHelper.shared.getDate(fromString: endDateString)!
        
        let numPhotos = dic["numPhotos"] as! Int
        let winner = dic["_winner"] as? String ?? nil
        
        return Challenge(id, theme, startDate, endDate, imageUrl, numPhotos, winner)
    }
    
    
}

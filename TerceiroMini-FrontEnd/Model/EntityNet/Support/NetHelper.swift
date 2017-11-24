//
//  NetHelper.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

/**
 
 This class contains the methos that parses the jsons into dictionararies.
 */
class NetHelper {
    
    private init() {}
    
    /**
     
     Extracts a dictionary array from a json.
     
     - parameter json: Json.
     - parameter key: The key to unwrap the response object.
     */
    class func extractDictionaryArray(fromJson json: Any, key: String) -> [[String: Any]]? {
        
        guard let j = json as? [String: Any] else {
            return nil
        }
        
        return j[key] as? [[String: Any]]
    }
    
    /**
     
     Extracts a dictionary from a json.
     
     - parameter json: Json.
     - parameter key: The key to unwrap the response object.
     */
    class func extractDictionary(fromJson json: Any, key: String) -> [String: Any]? {
        
        guard let j = json as? [String: Any] else {
            return nil
        }
        
        return j[key] as? [String: Any]
    }
    
}

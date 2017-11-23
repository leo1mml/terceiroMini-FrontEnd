//
//  NetHelper.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class NetHelper {
    
    static func extractDictionaryArray(fromJson json: Any, key: String) -> [[String: Any]]? {
        
        guard let j = json as? [String: Any] else {
            return nil
        }
        
        return j[key] as? [[String: Any]]
    }
    
    static func extractDictionary(fromJson json: Any, key: String) -> [String: Any]? {
        
        guard let j = json as? [String: Any] else {
            return nil
        }
        
        return j[key] as? [String: Any]
    }
    
}

//
//  Validator.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

extension UserNet {
    
    class Validator {
        
        class func obtainError(fromJson json: Any) -> Error? {
            
            guard let dic = json as? [String: Any] else {
                return nil
            }
            
            guard let errCode = dic["code"] as? Int else {
                return nil
            }
            
            switch errCode {
            case 11000:
                return UserError.alreadyExists
            default:
                return UserError.unknownError
            }
        }
        
        enum UserError: Error {
            
            case alreadyExists
            case unknownError
        }
    }
}

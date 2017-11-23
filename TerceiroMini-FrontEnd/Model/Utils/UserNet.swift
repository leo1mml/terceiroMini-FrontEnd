//
//  UserNet.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Alamofire

class UserNet {
    
    let domain: String
    
    init(domain: String) {
        self.domain = domain + "/users"
    }
    
    func add(user: User, completion: @escaping (User?, String?, Error?) -> Void) {
        let userDictionary = buildDictionary(fromUser: user)
        
        Alamofire.request(domain, method: .post, parameters: userDictionary, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard let val = response.value, let res = response.response, response.error == nil else {
                completion(nil, nil, response.error!)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "user")!
            
            let user = self.buildUser(fromDicitionary: dic)
            let token = res.allHeaderFields["x-auth"] as? String
            
            completion(user, token, nil)
        }
    }
    
    func getAll(completion: @escaping ([User]?, Error?) -> Void) {
        
        Alamofire.request(domain).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error!)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "users")!
            let ret = self.buildUserArray(fromDictionaryArray: arr)
            
            completion(ret, nil)
        }
    }
    
    func get(byToken t: String, completion: @escaping (User?, Error?) -> Void) {
        let completeDomain = domain + "/me"
        let header = ["x-auth": t]
        
        Alamofire.request(completeDomain, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error!)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "user")!
            let user = self.buildUser(fromDicitionary: dic)
            
            completion(user, nil)
        }
    }
    
    func logout(token: String, completion: @escaping (Bool) -> Void) {
        let completeDomain = domain + "/me/token"
        let header = ["x-auth": token]
        
        Alamofire.request(completeDomain, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            guard let code = response.response?.statusCode else {
                completion(false)
                return
            }
            
            completion(code == 200)
        }
    }
    
    func buildUserArray(fromDictionaryArray arr: [[String: Any]]) -> [User] {
        
        return arr.map { dic -> User in
            
            return buildUser(fromDicitionary: dic)
        }
    }
    
    func buildUser(fromDicitionary: [String: Any]) -> User {
        return User()
    }
    
    func buildDictionary(fromUser: User) -> [String: Any] {
        return [:]
    }
}

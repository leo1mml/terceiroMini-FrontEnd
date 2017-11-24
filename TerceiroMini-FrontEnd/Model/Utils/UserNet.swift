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
    
    private init() {}
    
    class func add(user: User, completion: @escaping (User?, String?, Error?) -> Void) {
        let userDictionary = buildDictionary(fromUser: user)
        
        Alamofire.request(R.usersDomain, method: .post, parameters: userDictionary, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
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
    
    class func getAll(completion: @escaping ([User]?, Error?) -> Void) {
        
        Alamofire.request(R.usersDomain).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error!)
                return
            }
            
            let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "users")!
            let ret = self.buildUserArray(fromDictionaryArray: arr)
            
            completion(ret, nil)
        }
    }
    
    class func get(byToken t: String, completion: @escaping (User?, Error?) -> Void) {
        let completeDomain = R.usersDomain + "/me"
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
    
    class func logout(token: String, completion: @escaping (Bool) -> Void) {
        let completeDomain = R.usersDomain + "/me/token"
        let header = ["x-auth": token]
        
        Alamofire.request(completeDomain, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            guard let code = response.response?.statusCode else {
                completion(false)
                return
            }
            
            completion(code == 200)
        }
    }
    
    class func get(byId id: String, completion: @escaping (User?, Error?) -> Void) {
        let completeDomain = R.usersDomain + "/\(id)"
        
        Alamofire.request(completeDomain).responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error!)
                return
            }
            
            let dic = NetHelper.extractDictionary(fromJson: val, key: "user")!
            let usr = self.buildUser(fromDicitionary: dic)
            
            completion(usr, nil)
        }
    }
    
    class func delete(byId id: String, completion: @escaping (Bool) -> Void) {
        let completeDomain = R.usersDomain + "/\(id)"
        
        Alamofire.request(completeDomain, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard let code = response.response?.statusCode else {
                completion(false)
                return
            }
            
            completion(code == 200)
        }
    }
    
    class func createLogin(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        let completeDomain = R.usersDomain + "/login"
        let login = ["userName": username, "email": email, "password": password]
        
        Alamofire.request(completeDomain, method: .post, parameters: login, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard let code = response.response?.statusCode else {
                completion(false)
                return
            }
            
            completion(code == 200)
        }
    }
    
    class func buildUserArray(fromDictionaryArray arr: [[String: Any]]) -> [User] {
        
        return arr.map { dic -> User in
            
            return buildUser(fromDicitionary: dic)
        }
    }
    
    class func buildUser(fromDicitionary d: [String: Any]) -> User {
        
        let id = d["_id"] as! String
        let email = d["email"] as! String
        let name = d["name"] as! String
        let username = d["userName"] as! String
        
        return User(id, email, name, username)
    }
    
    class func buildDictionary(fromUser u: User) -> [String: Any] {
        
        return ["_id": u.id ?? "",
                "email": u.email,
                "name": u.name,
                "userName": u.username]
    }
}

//
//  UserNet.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Alamofire

/**
 
 This class manages the web service/app user data flow. It must be used without instanciating the class.
 */
class UserNet {
    
    private init() {}
    
    /**
     
     Adds a new user to the database.
     
     - parameter user: The new user.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter usr: The user data that has being saved.
     - parameter tkn: The server comunication token of the device.
     - parameter err: The erro that ocurred.
     */
    class func add(user: User, completion: @escaping (_ usr: User?,_ tkn: String?,_ err: Error?) -> Void) {
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
    
    /**
     
     Gets the data of all the users in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter usrs: The data of the users.
     - parameter err: The that ocurred.
     */
    class func getAll(completion: @escaping (_ usrs: [User]?, _ err: Error?) -> Void) {
        
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
    
    /**
     
     Gets an user by the server comunication token.
     
     - parameter token: Server comunication token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter usr: The user data.
     - parameter err: The error that ocurred.
     */
    class func get(byToken token: String, completion: @escaping (_ usr: User?, _ err: Error?) -> Void) {
        let completeDomain = R.usersDomain + "/me"
        let header = ["x-auth": token]
        
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
    
    /**
     
     Kills the comunication between a device and the server by throwing out the token.
     
     - parameter token: Server comunication token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter success: A boolean flag indicating if the task was completed successfully.
     */
    class func logout(token: String, completion: @escaping (_ success: Bool) -> Void) {
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
    
    /**
     
     Get an user by the id.
     
     - parameter id: The user id.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter usr: The user data.
     - parameter err: The error that ocurred.
     */
    class func get(byId id: String, completion: @escaping (_ usr: User?, _ err: Error?) -> Void) {
        let completeDomain = R.usersDomain + "/id/\(id)"
        
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
    
    /**
     
     Deletes an user from the database.
     
     - parameter id: The id of the user.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter success: A boolean flag indicating if the task was completed successfully.
     */
    class func delete(byId id: String, completion: @escaping (_ success: Bool) -> Void) {
        let completeDomain = R.usersDomain + "/deleteById/\(id)"
        
        Alamofire.request(completeDomain, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard let code = response.response?.statusCode else {
                completion(false)
                return
            }
            
            completion(code == 200)
        }
    }
    
    /**
     
     Creates a new login in the database.
     
     - parameter username: The new username.
     - parameter email: The users email.
     - parameter password: The users password.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter success: A boolean flag indicating if the task was completed successfully.
     */
    class func createLogin(username: String, email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
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
    
    /**
     
     Creates a new array of users from a dictionary array.
     
     - parameter arr: A dictionary array.
     */
    private class func buildUserArray(fromDictionaryArray arr: [[String: Any]]) -> [User] {
        
        return arr.map { dic -> User in
            
            return buildUser(fromDicitionary: dic)
        }
    }
    
    /**
     
     Creates a new instance of user form a dicitonary.
     
     - parameter dic: A dictionary.
     */
    private class func buildUser(fromDicitionary dic: [String: Any]) -> User {
        
        let id = dic["_id"] as! String
        let email = dic["email"] as! String
        let name = dic["name"] as! String
        let username = dic["userName"] as! String
        
        return User(id, email, name, username)
    }
    
    /**
     
     Creates a new dictionary from an user.
     
     - parameter u: The user data.
     */
    private class func buildDictionary(fromUser u: User) -> [String: Any] {
        
        return ["_id": u.id ?? "",
                "email": u.email,
                "name": u.name,
                "userName": u.username]
    }
}

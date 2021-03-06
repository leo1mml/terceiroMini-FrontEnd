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
    
    // MARK: - Web Service methods
    
    /**
     
     Adds a new user to the database.
     
     - parameter user: The new user.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter u: The user data that has being saved.
     - parameter t: The server comunication token of the device.
     - parameter e: The erro that ocurred.
     */
    class func add(user: User, password: String, completion: @escaping (_ u: User?,_ t: String?,_ errorMessage: String?) -> Void) {
        var dic = buildDictionary(fromUser: user)
        dic["password"] = password
        
        Alamofire.request(R.usersDomain, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if(response.response?.statusCode == 400){
                guard let error = NetHelper.extractDictionary(fromJson: response.value!, key: "error") else {return}
                if let code = error["code"]{
                    let codeNumber = code as! Int
                    if(codeNumber == 11000){
                        completion(nil, nil, "Email already in use")
                        return
                    }
                }
                guard let errors = NetHelper.extractDictionary(fromJson: error, key: "errors") else {return}
                if let emailError = NetHelper.extractDictionary(fromJson: errors["email"] ?? "", key: "properties"){
                    let message = emailError["message"] as! String
                    completion(nil, nil, message)
                    return
                }
                if let passwordError = NetHelper.extractDictionary(fromJson: errors["password"] ?? "", key: "properties"){
                    let message = passwordError["message"] as! String
                    completion(nil, nil, message)
                    return
                }
            
                return
            }
            
            guard let val = response.value else {
                completion(nil, nil, "Error not identified")
                return
            }
            
            guard let dic = NetHelper.extractDictionary(fromJson: val, key: "user") else {return}
            
            let user = self.buildUser(fromDicitionary: dic)
            let token = response.response!.allHeaderFields["X-Auth"] as? String
            
            completion(user, token, nil)
        }
    }
    
    /**
     
     Gets the data of all the users in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter u: The users retrieved by the task.
     - parameter e: The that ocurred.
     */
    class func getAll(completion: @escaping (_ u: [User]?, _ e: Error?) -> Void) {
        
        Alamofire.request(R.usersDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            guard let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "users") else {return}
            let ret = self.buildUserArray(fromDictionaryArray: arr)
            
            completion(ret, nil)
        }
    }
    
    /**
     Gets the data of all the users in the database.
     
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter lastWinners: The users retrieved by the task.
     - parameter error: The error that may occur.
     */
    
    class func getLastWinners(completion: @escaping (_ lastWinners: [User]?, _ error: Error?) -> Void) {
        let completeDomain = R.usersDomain + "/getLastWinners"
        Alamofire.request(completeDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            guard let arr = NetHelper.extractDictionaryArray(fromJson: val, key: "users") else {return}
            let ret = self.buildUserArray(fromDictionaryArray: arr)
            
            completion(ret, nil)
        }
    }
    
    /**
     
     Gets an user by the server comunication token.
     
     - parameter token: Server comunication token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter u: The user retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func get(byToken token: String, completion: @escaping (_ u: User?, _ e: Error?) -> Void) {
        let completeDomain = R.usersDomain + "/me"
        let header = ["x-auth": token]
        
        Alamofire.request(completeDomain, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            guard let dic = NetHelper.extractDictionary(fromJson: val, key: "user") else {return}
            let user = self.buildUser(fromDicitionary: dic)
            
            completion(user, nil)
        }
    }
    
    /**
     
     Kills the comunication between a device and the server by throwing out the token.
     
     - parameter token: Server comunication token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter s: A boolean flag indicating if the task was completed successfully.
     */
    class func logout(token: String, completion: @escaping (_ s: Bool) -> Void) {
        let completeDomain = R.usersDomain + "/me/token"
        let header = ["x-auth": token]
        
        Alamofire.request(completeDomain, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { response in
            
            guard let code = response.response?.statusCode else {
                completion(false)
                return
            }
            UserDefaults.standard.set(nil, forKey: "token")
            completion(code == 200)
        }
    }
    
    /**
     
     Get an user by the id.
     
     - parameter id: The user id.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter u: The user retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func get(byId id: String, completion: @escaping (_ u: User?, _ e: Error?) -> Void) {
        let completeDomain = R.usersDomain + "/id/\(id)"
        
        Alamofire.request(completeDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            if let dic = NetHelper.extractDictionary(fromJson: val, key: "user"){
                let usr = self.buildUser(fromDicitionary: dic)
                completion(usr, nil)
            }
        }
    }
    
    /**
     
     Deletes an user from the database.
     
     - parameter id: The id of the user.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter s: A boolean flag indicating if the task was completed successfully.
     */
    class func delete(byId id: String, completion: @escaping (_ s: Bool) -> Void) {
        let completeDomain = R.usersDomain + "/deleteById/\(id)"
        
        Alamofire.request(completeDomain, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            
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
     - parameter u: The user retrieved by the task.
     - parameter t: The token retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func createLogin(username: String?, email: String, password: String, completion: @escaping (_ u: User?, _ t: String?, _ e: Error?) -> Void) {
        let completeDomain = R.usersDomain + "/login"
        let login = ["userName": username ?? "", "email": email, "password": password]
        
        Alamofire.request(completeDomain, method: .post, parameters: login, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, nil, response.error)
                return
            }
            
            if let dic = NetHelper.extractDictionary(fromJson: val, key: "user"){
                let usr = buildUser(fromDicitionary: dic)
                
                let tkn = response.response?.allHeaderFields["X-Auth"] as? String
                
                completion(usr, tkn, nil)
            }
        }
    }
    
    /**
     
     Creates a new login with facebook in the database.
     
     - parameter name: The new name.
     - parameter email: The users email.
     - parameter token: The users token.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter u: The user retrieved by the task.
     - parameter t: The token retrieved by the task.
     - parameter e: The error that ocurred.
     */
    class func createLoginFacebook(name: String, email: String, profileImgUrl: String?, completion: @escaping (_ u: User?, _ t: String?, _ e: Error?) -> Void) {
        let completeDomain = R.usersDomain + "/addFacebookUser"
        let loginWithPhoto = ["name": name, "email": email, "profilePhoto": profileImgUrl ?? ""]
//        let login = ["name": name, "email": email]
        
        Alamofire.request(completeDomain, method: .post, parameters: loginWithPhoto, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, nil, response.error)
                return
            }
            
            if let dic = NetHelper.extractDictionary(fromJson: val, key: "user"){
                let usr = buildUser(fromDicitionary: dic)
                
                let tkn = response.response?.allHeaderFields["X-Auth"] as? String
                
                completion(usr, tkn, nil)
            }
        }
    }
    
    /**
     
     Creates a new login with facebook in the database.
     
     - parameter id: The id of the challenge.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter u: The user retrieved by the task.
     - parameter e: The error that ocurred.
     */
    
    class func getChallengeWinner(by challengeId: String, completion: @escaping (_ u: User?, _ e: Error?) -> Void){
        let completeDomain = R.usersDomain + "/getWinnerByChallenge/" + challengeId
        
        Alamofire.request(completeDomain).validate().responseJSON { response in
            
            guard let val = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            if let dic = NetHelper.extractDictionary(fromJson: val, key: "foundUser"){
                let usr = self.buildUser(fromDicitionary: dic)
                
                completion(usr, nil)
            }
        }
    }
    
    
    /**
     
     Patch user authenticated.
     
     - parameter token: token for authentication.
     - parameter user: User to be updated with.
     - parameter completion: A block of code to be executed once the task is complete.
     - parameter u: The user retrieved by the task.
     - parameter e: The error that ocurred.
     - parameter msg: the error message to be displayed
     */
    
    class func patchMe(token: String, user: User, completion: @escaping (_ u: User?, _ e: Error?,_ msg: String?) -> Void){
        let completeDomain = R.usersDomain + "/patchMe"
        let header = ["x-auth": token]
        let dic = buildDictionary(fromUser: user)
        
        Alamofire.request(completeDomain, method: .patch, parameters: dic, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if(response.response?.statusCode == 400){
                guard let error = NetHelper.extractDictionary(fromJson: response.value!, key: "error") else {return}
                if let code = error["code"]{
                    let codeNumber = code as! Int
                    if(codeNumber == 11000){
                        completion(nil, nil, "User Name already in use")
                        return
                    }
                }
                
                guard let errors = NetHelper.extractDictionary(fromJson: error, key: "errors") else {return}
                if let nameError = NetHelper.extractDictionary(fromJson: errors["name"] ?? "", key: "properties"){
                    let message = nameError["message"] as! String
                    completion(nil, nil, message)
                    return
                }
            }
            
            guard let val = response.value else {
                completion(nil, nil, "Error not identified")
                return
            }
            
            guard let dic = NetHelper.extractDictionary(fromJson: val, key: "user") else {return}
            
            let user = self.buildUser(fromDicitionary: dic)
            
            completion(user, nil, nil)
            
        }
        
        
    }
    
    
    class func changePasswordWithAuth(token: String, oldPassword: String, newPassword: String, completion: @escaping (_ msg: String) -> Void){
        var dic = [String: Any]()
        dic["oldPassword"] = oldPassword
        dic["newPassword"] = newPassword
        let header = ["x-auth": token]
        let completeDomain = R.usersDomain + "/changePasswordAuth"
        
        Alamofire.request(completeDomain, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) in
            
            guard response.error == nil else {
                completion("Usuário não autenticado, refaça o login e tente novamente.")
                return
            }
            
            completion("Senha alterada!")
            
        }
    }
    
    
    // MARK: - Auxiliar methods
    
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
        let username = dic["userName"] as? String
        let profileImageUrl = dic["profilePhoto"] as? String
        let birthDate = DateHelper.shared.getDate(fromString: (dic["birthDate"] as? String ?? ""))
        let sex = dic["sex"] as? Int
        
        
        return User(id, email, name, username, profileImageUrl, birthDate, sex)
    }
    
    /**
     
     Creates a new dictionary from an user.
     
     - parameter u: The user data.
     */
    private class func buildDictionary(fromUser u: User) -> [String: Any] {
        
        var dic = [String: Any]()
        
        if(u.email != nil){
            dic["email"] = u.email
        }
        if(u.id != nil){
            dic["_id"] = u.id
        }
        if(u.name != nil){
            dic["name"] = u.name
        }
        if(u.profilePhotoUrl != nil){
            dic["profilePhoto"] = u.profilePhotoUrl
        }
        if(u.birthDate != nil){
            dic["birthDate"] = DateHelper.shared.getString(fromDate: u.birthDate!)
        }
        if(u.sex != nil){
            dic["sex"] = u.sex
        }
        if(u.userName != nil){
            dic["userName"] = u.userName
        }
        
        return dic
    }
}

//
//  User.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    let id: String?
    let email: String
    let name: String
    let userName: String?
    let profilePhotoUrl: String?
    
    init(_ id: String? = nil, _ email: String, _ name: String, _ username: String?, _ profilePhotoUrl: String?) {
        self.id = id
        self.email = email
        self.name = name
        self.userName = username
        self.profilePhotoUrl = profilePhotoUrl
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(userName, forKey: "username")
        aCoder.encode(profilePhotoUrl, forKey: "profilePhotoUrl")
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let username = aDecoder.decodeObject(forKey: "username") as? String ?? "empty"
        let profilePhotoUrl = aDecoder.decodeObject(forKey: "profilePhotoUrl") as? String ?? ""
        self.init(id, email, name, username, profilePhotoUrl)
        
    }
}

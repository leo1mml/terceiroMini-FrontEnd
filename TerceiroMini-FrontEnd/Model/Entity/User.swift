//
//  User.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class User {
    
    let id: String?
    let email: String
    let name: String
    let username: String?
    let profilePhotoUrl: String?
    
    init(_ id: String? = nil, _ email: String, _ name: String, _ username: String?, _ profilePhotoUrl: String?) {
        self.id = id
        self.email = email
        self.name = name
        self.username = username
        self.profilePhotoUrl = profilePhotoUrl
    }
}

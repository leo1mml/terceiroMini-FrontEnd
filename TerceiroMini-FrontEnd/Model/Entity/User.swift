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
    let username: String
    
    init(id: String? = nil, email: String, name: String, username: String) {
        self.id = id
        self.email = email
        self.name = name
        self.username = username
    }
}

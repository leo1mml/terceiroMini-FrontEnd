//
//  Photo.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class Photo {
    
    let id: String?
    let url: String?
    let ownerId: String
    let challengeId: String
    
    init(_ id: String? = nil, _ url: String? = nil, _ ownerId: String, _ challengeId: String) {
        self.id = id
        self.url = url
        self.ownerId = ownerId
        self.challengeId = challengeId
    }
}
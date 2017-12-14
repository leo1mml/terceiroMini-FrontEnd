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
    let votes : [String]
    
    init(_ id: String? = nil, _ url: String? = nil, _ ownerId: String, _ challengeId: String, _ votes: [String]) {
        self.id = id
        self.url = url
        self.ownerId = ownerId
        self.challengeId = challengeId
        self.votes = votes
    }
}

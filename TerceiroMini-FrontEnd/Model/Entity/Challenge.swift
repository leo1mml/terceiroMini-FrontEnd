//
//  Challenge.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class Challenge {
    
    let id: String
    let theme: String
    let startDate: Date
    let endDate: Date
    let imageUrl: String
    let numPhotos: Int
    var winner: String?
    
    var isOver: Bool {

        get {
            return endDate.compare(Date()) == .orderedAscending
        }
    }

    var hasBegun: Bool {

        get {
            return startDate.compare(Date()) == .orderedAscending
        }
    }

    var isHappening: Bool {

        get {
            return hasBegun && !isOver
        }
    }
    
    init(_ id: String, _ theme: String, _ startDate: Date, _ endDate: Date, _ imageUrl: String, _ numPhotos: Int, _ winner: String?) {
        self.id = id
        self.theme = theme
        self.startDate = startDate
        self.endDate = endDate
        self.imageUrl = imageUrl
        self.numPhotos = numPhotos
        self.winner = winner
    }
}

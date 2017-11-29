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
    
    init(_ id: String, _ theme: String, _ startDate: Date, _ endDate: Date) {
        self.id = id
        self.theme = theme
        self.startDate = startDate
        self.endDate = endDate
    }
}

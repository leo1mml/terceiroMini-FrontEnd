//
//  Challenge.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 23/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

class Challenge {
    
    let id: String
    let theme: String
    let startDate: String
    let endDate: String
    let imageUrl: String
    var image: UIImage?
    
//    var isOver: Bool {
//
//        get {
//            return endDate.compare(Date()) == .orderedAscending
//        }
//    }
//
//    var hasBegun: Bool {
//
//        get {
//            return startDate.compare(Date()) == .orderedAscending
//        }
//    }
//
//    var isHappening: Bool {
//
//        get {
//            return hasBegun && !isOver
//        }
//    }
    
    init(_ id: String, _ theme: String, _ startDate: String, _ endDate: String, _ imageUrl: String) {
        self.id = id
        self.theme = theme
        self.startDate = startDate
        self.endDate = endDate
        self.imageUrl = imageUrl
    }
}

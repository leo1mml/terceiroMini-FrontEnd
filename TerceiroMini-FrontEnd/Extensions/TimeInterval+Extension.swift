//
//  TimeInterval+Extension.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 04/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func format() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 4
        return formatter.string(from: self)
    }
}

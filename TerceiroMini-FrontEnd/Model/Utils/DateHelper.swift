//
//  DateHelper.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let shared = DateHelper()
    private init() {
        
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
    
    let formatter: DateFormatter
    
    func getDate(fromString string: String) -> Date? {
        
        return formatter.date(from: string)
    }
    
    func getString(fromDate date: Date) -> String? {
        
        return formatter.string(from: date)
    }
}

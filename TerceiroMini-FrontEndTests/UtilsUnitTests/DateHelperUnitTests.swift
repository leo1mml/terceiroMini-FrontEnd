//
//  DateHelperUnitTests.swift
//  TerceiroMini-FrontEndTests
//
//  Created by Gabriel Reynoso on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import XCTest
@testable import TerceiroMini_FrontEnd

class DateHelperUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetDateFromString() {
        
        let date = DateHelper.shared.getDate(fromString: "2017-11-30T18:25:43.511Z")
        
        XCTAssertNotNil(date)
    }
    
    func testGetStringFromDate() {
        
        let string = DateHelper.shared.getString(fromDate: Date())
        
        XCTAssertNotNil(string)
    }
    
}

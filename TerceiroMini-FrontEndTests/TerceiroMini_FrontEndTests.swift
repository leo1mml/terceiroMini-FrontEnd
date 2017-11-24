//
//  TerceiroMini_FrontEndTests.swift
//  TerceiroMini-FrontEndTests
//
//  Created by Leonel Menezes on 06/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import XCTest
@testable import TerceiroMini_FrontEnd

class TerceiroMini_FrontEndTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetById() {
        let userNet = UserNet(domain: "http://photoappchallenge.herokuapp.com")
        let id = "5a0c92e6515a080014694f80" // leo1mml
        
        let exp = expectation(description: "Get User")
        
        userNet.get(byId: id) { (usr, err) in
            
            guard let u = usr else {
                print("Oops!")
                return
            }
            
            if u.username == "leo1mml" {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
}

//
//  NetUnitTests.swift
//  TerceiroMini-FrontEndTests
//
//  Created by Gabriel Reynoso on 24/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import XCTest
@testable import TerceiroMini_FrontEnd

class NetUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testAddUser() {
//        let usr = User(email: "gabriel@teste.com", name: "Gabriel", username: "folameloma")
//
//        let exp = expectation(description: "Add User")
//
//        userNet.add(user: usr) { (usr, tkn, err) in
//
//            guard let u = usr, let t = tkn else {
//                return
//            }
//
//            if u.username == "folameloma" {
//                print("Generated Token: \(t)")
//                exp.fulfill()
//            }
//        }
//
//        wait(for: [exp], timeout: 2)
//    }
    
    func testGetAll() {
        let exp = expectation(description: "Get All Users")
        
        UserNet.getAll { (usrs, err) in
            
            guard let u = usrs, err == nil  else {
                return
            }
            
            if !u.isEmpty {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testGetById() {
        let id = "5a0c92e6515a080014694f80" // leo1mml
        
        let exp = expectation(description: "Get User")
        
        UserNet.get(byId: id) { (usr, err) in
            
            guard let u = usr else {
                return
            }
            
            if u.username == "leo1mml" {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
}

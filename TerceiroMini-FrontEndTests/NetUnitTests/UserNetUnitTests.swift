//
//  NetUnitTests.swift
//  TerceiroMini-FrontEndTests
//
//  Created by Gabriel Reynoso on 24/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import XCTest
@testable import TerceiroMini_FrontEnd

class UserNetUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddUser() {
        let exp = expectation(description: "Add User")
        let usr = User(nil, "gabriel@teste.com", "Gabriel", "folameloma")

        UserNet.add(user: usr, password: "vaquinha123") { (usr, tkn, err) in

            guard let u = usr, let t = tkn else { return }

            if u.username == "folameloma" {
                print("Generated Token: \(t)")
                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 2)
    }
    
    func testUserAlreadyExistsError() {
        let exp = expectation(description: "User Already Exists")
        let usr = User(nil, "gabriel@teste.com", "Gabriel", "folameloma")
        
        UserNet.add(user: usr, password: "vaquinha123") { (usr, tkn, err) in
            
            guard let _ = err else { return }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }
    
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
    
    func testGetByToken() {
        let exp = expectation(description: "Get User By Token")
        let token = ""
        
        UserNet.get(byToken: token) { (usr, err) in
            
            guard let u = usr, err == nil else {
                return
            }
            
            if u.username == "" {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testLogout() {
        let exp = expectation(description: "Logout")
        let token = ""
        
        UserNet.logout(token: token) { (success) in
            
            if success {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testGetById() {
        let exp = expectation(description: "Get User")
        let id = "5a21a323391838001482d1f4" // folameloma
        
        UserNet.get(byId: id) { (usr, err) in
            
            guard let u = usr else {
                return
            }
            
            if u.username == "folameloma" {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testDeleteById() {
        let exp = expectation(description: "Delete By Id")
        let id = ""
        
        UserNet.delete(byId: id) { (success) in
            
            if success {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testCreateLogin() {
        let exp = expectation(description: "Create Login")
        let username = "folameloma"
        let email = "gabriel@teste.com"
        let password = "12345678"
        
        UserNet.createLogin(username: username, email: email, password: password) { (success) in
            
            if success {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
}

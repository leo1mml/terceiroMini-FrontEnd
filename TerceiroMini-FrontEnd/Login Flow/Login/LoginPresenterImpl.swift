//
//  LoginPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 14/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class LoginPresenterImpl: LoginPresenter {
    
    var view: LoginView
    
    init(loginViewImpl view: LoginView) {
        self.view = view
    }
    
    func validateCredentials(username: String, password: String) {
        
    }
    
    func goBack() {
        view.goBack()
    }
    
    func forgotPassword() {
        
    }
    
    func createAccount() {
        view.goToRegister()
    }
}

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
    
    func validateCredentials(email: String, password: String) {
        
        NetworkManager.createLogin(email: email, username: nil, password: password) { usr, tkn, err in
            
            guard err == nil else {
                self.view.showInvalidCredentialsError()
                return
            }
            
            UserDefaults.standard.set(tkn, forKey: "token")
            let encodedUser = NSKeyedArchiver.archivedData(withRootObject: usr!)
            UserDefaults.standard.set(encodedUser, forKey: "logedUser")
            UserDefaults.standard.synchronize()
            self.view.goToApp()
        }
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

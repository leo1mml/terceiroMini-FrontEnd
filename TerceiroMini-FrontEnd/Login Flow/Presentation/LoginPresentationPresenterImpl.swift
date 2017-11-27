//
//  LoginPresentationPresenterImpl.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 27/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class LoginPresentationPresenterImpl: LoginPresentationPresenter {
    
    var view: LoginPresentationView
    
    init(loginPresentationViewImpl view: LoginPresentationView) {
        self.view = view
    }
    
    func exitButtonClicked() {
        view.exitLoginPresentation()
    }
    
    func emailLoginButtonClicked() {
        view.goToLogin()
    }
    
    func facebookLoginButtonClicked() {
        
    }
    
    func createAccountButtonClicked() {
        view.goToRegister()
    }
    
}

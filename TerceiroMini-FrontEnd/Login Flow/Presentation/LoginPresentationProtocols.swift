//
//  LoginPresentationProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 27/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol LoginPresentationPresenter {
    
    func exitButtonClicked()
    func emailLoginButtonClicked()
    func facebookLoginButtonClicked()
    func createAccountButtonClicked()
}

protocol LoginPresentationView {
    
    func exitLoginPresentation()
    func goToLogin()
    func goToRegister()
    func goToApp()
}

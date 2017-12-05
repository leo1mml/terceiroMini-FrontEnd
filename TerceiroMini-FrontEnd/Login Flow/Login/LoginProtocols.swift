//
//  LoginProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 14/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol LoginView {
    
    func showMissingFieldsError()
    func showInvalidCredentialsError()
    func goToRegister()
    func goBack()
}

protocol LoginPresenter {
    
    func validateCredentials(username: String, password: String)
    func goBack()
    func forgotPassword()
    func createAccount()
}

//
//  CadastroProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol SignUpView {
    
    func changeScreen()
    func showInvalidRepeatPassword()
    func showInvalidUsername()
    func showInvalidEmail()
}

protocol SignUpPresenter {
    
    func validateData(name: String, email: String, username: String, password: String, repeatPassword: String)
}

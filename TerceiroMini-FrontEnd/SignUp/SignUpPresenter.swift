//
//  CadastroPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class SignUpPresenterImpl: SignUpPresenter {
    
    var view: SignUpView?
    
    init(signUpView: SignUpView) {
        self.view = signUpView
    }
    
    func validateData(name: String, email: String, username: String, password: String, repeatPassword: String) {
        if password == repeatPassword {
            
            // validar username e email.
            
        } else {
            // the key is not equal
            view?.showInvalidRepeatPassword()
        }
    }
    
}

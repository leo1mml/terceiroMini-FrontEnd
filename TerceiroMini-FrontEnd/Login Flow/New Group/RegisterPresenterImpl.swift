//
//  RegisterPresenterImpl.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 05/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class RegisterPresenterImpl: RegisterPresenter {
    
    var view: RegisterView
    
    init(registerView view: RegisterView) {
        self.view = view
    }
    
    func goBack() {
        view.goBack()
    }
    
    func addUser(name: String, email: String, password: String, confirm: String) {
        
        guard password == confirm else {
            view.showNonMatchingPasswordError()
            return
        }
        
        let user = User(nil, email, name, nil, nil)
        
        NetworkManager.addUser(user, password: password) { usr, tkn, errMsg in

            guard errMsg == nil else {
                
                self.view.showUpdateError(message: errMsg!)
                return
            }

            UserDefaults.standard.set(tkn, forKey: "token")
            self.view.goToApp()
        }
    }
    
}

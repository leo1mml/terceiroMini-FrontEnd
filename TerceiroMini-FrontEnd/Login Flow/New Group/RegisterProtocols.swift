//
//  RegisterProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 05/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol RegisterPresenter {
    
    func goBack()
    func addUser(name: String, email: String, password: String, confirm: String)
}

protocol RegisterView {
    
    func goBack()
    func goToApp()
    func showUpdateError()
    func showNonMatchingPasswordError()
}

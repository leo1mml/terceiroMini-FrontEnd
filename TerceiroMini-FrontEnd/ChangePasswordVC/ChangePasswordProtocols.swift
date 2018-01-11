//
//  ChangePasswordProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 03/01/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import Foundation

protocol ChangePasswordView {
    
}

protocol ChangePasswordPresenter {
    func sendChangesToServer(oldPassword: String, newPassword: String, completion: @escaping (_ token: String) -> Void)
}

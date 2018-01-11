//
//  ChangePasswordPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 03/01/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import Foundation

class ChangePasswordPresenterImp: ChangePasswordPresenter {
    var view: ChangePasswordView?
    var loggedUser : User? {
        didSet{
            
        }
    }
    
    init(_ view: ChangePasswordView) {
        self.view = view
    }
    func sendChangesToServer(oldPassword: String, newPassword: String, completion: @escaping (String) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? "NO TOKEN"
        NetworkManager.changePasswordWithAuth(token: token, oldPassword: oldPassword, newPassword: newPassword) { (msg) in
            completion(msg)
        }
    }
    
    
    
}

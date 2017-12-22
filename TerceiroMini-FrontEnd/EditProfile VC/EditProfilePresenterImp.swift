//
//  EditProfilePresenterImp.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 22/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class EditProfilePresenterImp : EditProfilePresenter {
    
    var view : EditProfileView?
    
    init(_ view: EditProfileView) {
        self.view = view
    }
    
    func recoverLogedUser() {
        let userData = UserDefaults.standard.object(forKey: "logedUser") as! Data
        let logedUser = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
        view?.setProfileImage(url: logedUser.profilePhotoUrl!)
        view?.setUserDataHolders(nome: logedUser.name, username: logedUser.username, email: logedUser.email, birthDate: nil, sex: nil)
    }
    
    
}

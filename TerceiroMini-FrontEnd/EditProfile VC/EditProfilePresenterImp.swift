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
    var birthDate : String?
    var profilePhotoUrlChanged : String? {
        didSet {
            
        }
    }
    
    init(_ view: EditProfileView) {
        self.view = view
    }
    
    func recoverLogedUser() {
        let userData = UserDefaults.standard.object(forKey: "logedUser") as! Data
        let logedUser = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
        view?.setProfileImage(url: logedUser.profilePhotoUrl!)
        view?.setUserDataHolders(name: logedUser.name ?? "Name", username: logedUser.userName, email: logedUser.email!, birthDate: nil, sex: nil)
    }
    
    func sendChangesToServer(name: String?, username: String?, sex: Int?, birthDate: String?) {
        
        
    }
}

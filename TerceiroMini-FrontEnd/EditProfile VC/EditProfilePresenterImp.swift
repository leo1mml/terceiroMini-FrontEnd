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
        view?.setUserDataHolders(name: logedUser.name ?? "Name", username: logedUser.userName, birthDate: nil, sex: nil)
    }
    
    func sendChangesToServer(name: String?, username: String?, sex: Int?, birthDate: String?) {
        let date = DateHelper.shared.getDate(fromString: birthDate ?? "")
        let userData = UserDefaults.standard.object(forKey: "logedUser") as! Data
        let logedUser = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
        let user = User(logedUser.id, nil, name, username, nil, date, sex)
        NetworkManager.patchMe(token: UserDefaults.standard.string(forKey: "token")!, user: user) { (usr, err, msg) in
            if(msg != nil){
                print(msg!)
                self.view?.sendErrorMessage(message: msg!)
                return
            }
            if(err != nil){
                print(err!)
                self.view?.sendUknownErrorBanner()
                return
            }
            var sex : String?
            if(usr?.sex != nil){
                switch usr?.sex {
                case 0?:
                    sex = "Não especificado"
                    break
                case 1?:
                    sex = "Masculino"
                    break
                case 2?:
                    sex = "Feminino"
                default:
                    sex = "None"
                    break
                }
            }
            self.view?.sendSuccessBanner()
            self.view?.setUserDataHolders(name: usr?.name, username: usr?.userName, birthDate: nil, sex: sex)
        }
        
    }
}

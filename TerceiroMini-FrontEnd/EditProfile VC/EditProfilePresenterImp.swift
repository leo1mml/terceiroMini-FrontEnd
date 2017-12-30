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
    let formatter = DateFormatter()
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
        var dateStr : String?
        if(logedUser.birthDate != nil){
            dateStr = DateHelper.shared.getString(fromDate: logedUser.birthDate!)
        }
        let sex = getSexString(id: logedUser.sex)
        view?.setProfileImage(url: logedUser.profilePhotoUrl!)
        view?.setUserDataHolders(name: logedUser.name ?? "Name", username: logedUser.userName, birthDate: dateStr, sex: sex)
    }
    
    func getSexString(id: Int?)-> String{
        var sex : String = "Sexo"
        switch id {
        case 1?:
            sex = "Masculino"
            break
        case 2?:
            sex = "Feminino"
            break
        case 9?:
            sex = "Não especificado"
            break
        default:
            sex = "Sexo"
            break
        }
        
        return sex
    }
    
    func sendChangesToServer(name: String?, username: String?, sex: Int?, birthDate: Date?) {
        let userData = UserDefaults.standard.object(forKey: "logedUser") as! Data
        let logedUser = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
        let user = User(logedUser.id, nil, name, username, nil, birthDate, sex)
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
            sex = self.getSexString(id: usr?.sex)
            self.view?.sendSuccessBanner()
            var dateString : String?
            if(birthDate != nil){
                dateString = DateHelper.shared.getString(fromDate: birthDate!)
            }
            self.view?.setUserDataHolders(name: usr?.name, username: usr?.userName, birthDate: dateString, sex: sex)
        }
        
    }
}

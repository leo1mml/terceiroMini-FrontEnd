//
//  EditProfilePresenterImp.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 22/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Cloudinary

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
    
    let cloudname = "clicks"
    let apiKey = "535385847914562"
    let uploadPreset = "clicksPreset"
    
    func sendPhotoToCloudinary(infoImage: UIImage) {
        let config = CLDConfiguration(cloudName: cloudname, apiKey: apiKey)
        let cloudinary = CLDCloudinary(configuration: config)
        let imageData = UIImageJPEGRepresentation(infoImage, 1.0)
        
        _ = cloudinary.createUploader().upload(data: imageData!, uploadPreset: uploadPreset, params: nil, progress: nil) {
            (result, error) in
            if (error != nil) {
                print("deu merda ao subir a foto para o cloudinary")
            }
            let userData = UserDefaults.standard.object(forKey: "logedUser") as! Data
            let logedUser = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
            let user = User(logedUser.id, nil, nil, nil, result?.url, nil, nil)
            NetworkManager.patchMe(token: UserDefaults.standard.string(forKey: "token")!, user: user, completion: { (user, error, string) in
                guard error == nil else {
                    self.view?.sendErrorMessage(message: "Não foi possivel enviar a foto")
                    return
                }
                logedUser.profilePhotoUrl = user?.profilePhotoUrl
                let encodedUser = NSKeyedArchiver.archivedData(withRootObject: logedUser)
                UserDefaults.standard.set(encodedUser, forKey: "logedUser")
                UserDefaults.standard.synchronize()
                self.view?.setProfileImage(url: (user?.profilePhotoUrl)!)
            })
        }
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

//
//  EditProfileVCProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 22/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

protocol EditProfileView {
    func setProfileImage(url: String)
    func setUserDataHolders(name: String?, username: String?, birthDate: String?, sex: String?)
    func sendErrorMessage(message: String)
    func sendUknownErrorBanner()
    func sendSuccessBanner()
}

protocol EditProfilePresenter {
    func recoverLogedUser()
    func sendChangesToServer(name: String?, username: String?, sex: Int?, birthDate: String?)
}

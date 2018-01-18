//
//  ConfigurationPresenterImp.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/01/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import Foundation

class ConfigurationPresenterImp: ConfigurationPresenter {
    
    var view: ConfigurationView?
    
    init(view: ConfigurationView) {
        self.view = view
    }
    
    func deleteToken() {
        NetworkManager.logout(token: UserDefaults.standard.string(forKey: "token")!) { (completed) in
            if(completed){
                self.view?.dismissScreen()
            }
        }
    }
}

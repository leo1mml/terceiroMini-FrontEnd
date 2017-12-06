//
//  RegisterPresenterImpl.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 05/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class RegisterPresenterImpl: RegisterPresenter {
    
    var view: RegisterView
    
    init(registerView view: RegisterView) {
        self.view = view
    }
    
    func goBack() {
        view.goBack()
    }
    
}

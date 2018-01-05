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
    
    init(_ view: ChangePasswordView) {
        self.view = view
    }
}

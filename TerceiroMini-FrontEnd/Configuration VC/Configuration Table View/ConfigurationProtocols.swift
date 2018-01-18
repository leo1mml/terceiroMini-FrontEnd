//
//  ConfigurationProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/01/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import Foundation


protocol ConfigurationView {
    func dismissScreen()
}

protocol ConfigurationPresenter {
    func deleteToken()
}

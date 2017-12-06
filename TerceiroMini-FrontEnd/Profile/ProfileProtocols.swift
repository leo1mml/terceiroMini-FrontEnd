//
//  PerfilProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 16/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileView {
    
    func receiveDatas(profileUserHolder: ProfileUserHolder)
    
}

protocol ProfilePresenter {
    
    func loadData()
    
}

//
//  ExtensionNewChallengeViewController+NewHeaderDelagate.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

extension NewChallengeViewController : NewChallengeHeaderDelegate{
    func mainButtonClicked() {
        
        switch state {
        case .open?:
            self.showPhotoMenu()
            
            break
        case .participating?:
            break
        case .finished?:
            //ir parao  ganhador
            goToProfileFromChallenge()
            break
        case ChallengeState.notLogged?:
            goToRegisterScreen()
            break
            
        default:
            break
        }
    }
    
    func backButtonClicked() {
        defaultStatusBar()
        self.navigationController?.popViewController(animated: true)
    }
 
}



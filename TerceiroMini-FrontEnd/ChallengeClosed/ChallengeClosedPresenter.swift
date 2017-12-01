//
//  ChallengeClosedPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class ChallengeClosedPresenterImpl: ChallengeClosedPresenter {
    
    var view: ChallengeClosedView?
    
    init(challengeClosedView: ChallengeClosedView) {
        self.view = challengeClosedView
    }
    
    func showReport() {
        view?.showAlert()
    }
    
    func chooseClick(index: Int) {
        
    }

}

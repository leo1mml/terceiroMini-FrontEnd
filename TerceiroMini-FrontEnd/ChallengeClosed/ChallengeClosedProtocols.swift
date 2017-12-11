//
//  ChallengeClosedProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol ChallengeClosedView {
    func showCurrentClick()
    func showAlert()
    func enableMyClickChosebuttonLabel()
    func enableChoseClickButton()
}

protocol ChallengeClosedPresenter {
    func showReport()
    func chooseClick(photo: Photo)
    func checkIfChosenClick()

}

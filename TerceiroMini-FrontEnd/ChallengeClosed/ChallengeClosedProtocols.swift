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
}

protocol ChallengeClosedPresenter {
    func showReport()
    func chooseClick(index: Int)
}

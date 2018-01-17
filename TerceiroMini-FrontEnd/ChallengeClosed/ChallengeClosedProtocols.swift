//
//  ChallengeClosedProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol ChallengeClosedView {
    func showAlert()
    func enableMyClickChosebuttonLabel()
    func enableChoseClickButton()
    func enableMyFavoriteClickChosebuttonLabel()
    func dissmissAndReloadParent()
}

protocol ChallengeClosedPresenter {
    func showReport()
    func checkIfChosenClick(currentPhoto: Photo)
    func vote(photo: Photo)
    func unvote(photo: Photo)
    func excludePhoto()

}

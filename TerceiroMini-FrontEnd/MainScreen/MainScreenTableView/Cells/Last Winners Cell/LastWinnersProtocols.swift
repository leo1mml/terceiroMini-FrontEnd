//
//  LastWinnersProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 04/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

protocol LastWinnersView {
    func styleWinnerImage(winnerPhoto: UIImageView)
    func styleProfilePhotoImage(winnerProfilePhoto: UIImageView)
    func appendNewUser(user: User)
    func appendChallenges(challenges: [Challenge])
}

protocol LastWinnersPresenter {
    func fetchLastChallenges()
    func fetchWinnerFor(challenges: [Challenge])
}

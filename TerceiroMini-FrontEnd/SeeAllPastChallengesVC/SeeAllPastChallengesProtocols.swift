//
//  SeeAllPastChallengesProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 06/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol SeeAllPastChallengesView {
    func appendNewUser(user: User)
    func appendChallenges(challenges: [Challenge])
//    func bidimensionalForChallenges(arr: [[Challenge]])
}

protocol SeeAllPastChallengesPresenter {
    func fetchWinnerFor(challenges: [Challenge])
    func fetchLastChallenges()
//    func transformChallengesIntoBidimensionalArray()
}

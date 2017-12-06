//
//  NextChallengesProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 05/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation


protocol NextChallengesCellView {
    func updateChallenges(challenges: [Challenge])
    
}

protocol NextChallengesCellPresenter {
    func fetchChallenges()
}

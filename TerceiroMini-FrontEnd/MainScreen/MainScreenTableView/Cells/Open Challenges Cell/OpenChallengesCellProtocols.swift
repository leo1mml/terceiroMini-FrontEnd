//
//  OpenChallengesCellProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol OpenChallengesCellView {
    func reloadCollectionView(with challenges: [Challenge])
}

protocol OpenChallengesCellPresenter {
    func fetchChallenges()
}

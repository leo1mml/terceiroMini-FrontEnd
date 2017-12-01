//
//  ChallengeCollectionViewPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Alamofire


class ChallengesCellPresenterImp: ChallengesCellPresenter {
    func fetchImage(url: String) {
        
    }
    
    
    var view : ChallengesCellView?
    
    init(challengeCellView: ChallengesCellView) {
        self.view = challengeCellView
    }
    
}

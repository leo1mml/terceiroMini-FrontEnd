//
//  NextChallengesCellPresenterImp.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 05/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class NextChallengesCellPresenterImp: NextChallengesCellPresenter {
    
    var view : NextChallengesCellView?
    
    init(_ view: NextChallengesCellView) {
        self.view = view
    }
    
    func fetchChallenges() {
        NetworkManager.getComingSoonChallenges { (challenges, err) in
            if (err != nil){
                return
            }
            self.view?.updateChallenges(challenges: challenges!)
        }
    }
    
    
}

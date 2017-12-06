//
//  LastWinnersPresenterImp.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 04/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

class LastWinnersPresenterImp: LastWinnersPresenter {
    var view : LastWinnersView?
    
    init(_ view: LastWinnersView) {
        self.view = view
    }
    
    func fetchLastChallenges() {
        NetworkManager.getLastChallenges { (challenges, err) in
            if(err == nil){
                self.view?.appendChallenges(challenges: challenges!)
//                self.view?.reloadCollectionView(with: challenges!)
            }
        }
    }
    
    func fetchWinnerFor(challenges: [Challenge]) {
        for challenge in challenges {
            NetworkManager.getUser(byId: challenge.winner!, completion: { (winner, err) in
                if let user = winner {
                    self.view?.appendNewUser(user: user)
                }
            })
        }
    }
    
    
    
    
    
}

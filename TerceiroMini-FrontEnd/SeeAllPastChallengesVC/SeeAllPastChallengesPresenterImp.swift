//
//  SeeAllPastChallengesPresenterImp.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 06/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class SeeAllPastChallengesPresenterImp: SeeAllPastChallengesPresenter {
    
    var view : SeeAllPastChallengesView?
    
    init(_ view: SeeAllPastChallengesView) {
        self.view = view
    }
    
    func fetchLastChallenges() {
        
        NetworkManager.getLastChallenges(completion: { (challenges, err) in
            if(err == nil){
                self.view?.appendChallenges(challenges: challenges!)
                //                self.view?.reloadCollectionView(with: challenges!)
            }
        }, numOfItems: 3)
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
    
//    func transformChallengesIntoBidimensionalArray() {
//        if let challenges = self.challenges?.sorted(by: { $0.endDate.compare($1.endDate) == .orderedDescending }){
//            let calendar = Calendar.current
//            var arr = [[Challenge]]()
//            var month = calendar.component(.month, from: challenges[0].endDate)
//            var year = calendar.component(.year, from: challenges[0].endDate)
//            var cont = 0
//            var challengesToAppend = [Challenge]()
//            while(cont < challenges.count){
//                if(calendar.component(.month, from: challenges[cont].endDate) == month && calendar.component(.year, from: challenges[cont].endDate) == year){
//                    challengesToAppend.append(challenges[cont])
//                    cont += 1
//                    continue
//                }
//                month = calendar.component(.month, from: challenges[cont].endDate)
//                year = calendar.component(.year, from: challenges[cont].endDate)
//                arr.append(challengesToAppend)
//                challengesToAppend = [Challenge]()
//            }
//            view?.bidimensionalForChallenges(arr: arr)
//        }
//    }
    
    
}


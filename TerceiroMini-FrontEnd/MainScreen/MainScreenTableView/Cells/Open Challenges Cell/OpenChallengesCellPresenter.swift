//
//  OpenChallengesCellPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit


class OpenChallengesCellPresenterImp: OpenChallengesCellPresenter {
    
    
    var view : OpenChallengesCellView?
    
    var challenges = [Challenge]()
    
    init(openChallengesCellView : OpenChallengesCellView) {
        self.view = openChallengesCellView
    }
    
    
    func fetchChallenges(){
        DispatchQueue.main.async {
            NetworkManager.getOpenChallenges(completion: { (challenges, err) in
                if let challenges = challenges{
                    self.view?.reloadCollectionView(with: challenges)
                }
            })
        }
        
    }
}

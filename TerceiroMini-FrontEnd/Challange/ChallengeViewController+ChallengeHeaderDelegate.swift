//
//  ChallengeViewController+ChallengeHeaderDelegate.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 01/12/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

extension ChallengeViewController: ChallengeHeaderDelegate, ChallengeHeaderDataSource {
    
    
//    func getMyClick() -> Photo? {
//        presenter.
//    }
//    
//    func getMyFavoriteClick() -> Photo? {
//        <#code#>
//    }
//    
//   
   
    
    func getChallengeName() -> String {
        return String()
    }
    
    func getNumberOfClicks() -> Int {
        return Int()
    }
    
    
    func getBackgroundImage() -> UIImage {
        return UIImage()
    }
    
    func getFeaturedPhotos() -> [UIImage] {
        return [UIImage]()
    }
    
    var challengeState: ChallengeState {
        return state
    }
    
    
    func mainButtonClicked() {
        if state == ChallengeState.open{
            //se nao
            self.showPhotoMenu()
            //presenter?.mainButtonClicked()
        }else{
            //presenter vai para o perfil do cara
            presenter?.presentProfile(challengeID: challengeID!)
        }
        
        
    }
}

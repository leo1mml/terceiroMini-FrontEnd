//
//  ChallengeViewController+ChallengeHeaderDelegate.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 01/12/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

extension ChallengeViewController: ChallengeHeaderDelegate, ChallengeHeaderDataSource {
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
        presenter?.mainButtonClicked()
    }
}
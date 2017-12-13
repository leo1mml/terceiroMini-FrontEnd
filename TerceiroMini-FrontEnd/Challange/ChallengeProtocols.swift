//
//  ChallengeProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 20/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

protocol ChallengeView{
    func changeMainPhoto()
    func changeScreen()
    func showTimer()
    func getPhoto()
    func takePhoto()
    func setChallengeState(state: ChallengeState)
    func showPhotoMenu()
    func showChallengeWinner(winner: User)
    func setHeader(theme: String, endDate: Date, mainImageURL: String, numPhotos: Int)
    func setChallengePhotos(photos: [Photo])
    func showCollectionPhotos()
    func goToExpandoPhotoView(parameter: ([Photo], Int))
    func showFeaturedCollectionView()
    func showNoImagesWarning()
}

protocol ChallengePresenter{
    func sendPhotoToCloudinary(infoImage: UIImage, challengeID: String)
    func mainButtonClicked()
    func getChallengeHeader(challengeID: String)
    func getChallengeImages(challengeID: String)
    func presentProfile(challengeID: String)
    func expandPhoto(photos:[String])
    func getChallengeFeaturedClicks(challengeID: String)
    
    
}

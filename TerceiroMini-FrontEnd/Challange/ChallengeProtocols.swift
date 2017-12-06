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
    func setHeader(theme: String, endDate: Date, mainImageURL: String, numPhotos: Int)
    func setChallengePhotos(photos: [Photo])
}

protocol ChallengePresenter{
    func sendPhotoToCloudinary(infoImage: UIImage, challengeID: String)
    func mainButtonClicked()
    func getChallengeHeader(challengeID: String)
    func getChallengeState(challenge: Challenge)
    func getChallengeImages(challengeID: String)
    
}

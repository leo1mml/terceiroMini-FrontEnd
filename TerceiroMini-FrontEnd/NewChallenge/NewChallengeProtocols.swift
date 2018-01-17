//
//  NewChallengeProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

protocol NewChallengeView{
    func setHeader(theme: String, mainImageURL: String,numPhotos: Int)
    func setHeaderStatusAsFinished(winner: User)
    func setHeaderStatusAsTimer(endDate: Date)
    func setHeaderButtonAsParticipating()
    func setHeaderButtonAsParticipate()
    func resolveState()
    func setUserLoggedIn(isLogged: Bool)
    func setFeaturedCollectionMyFavoriteClick(myFavoriteClick: Photo?)
    func setFeaturedCollectionMyClick(myClick: Photo?)
    func setChallengePhotos(photos: [Photo])
    func showCollectionPhotos()
    func showFeaturedCollectionView()
    func goToExpandPhotoView(parameter: ([Photo], Int))
    func setState(state: ChallengeState)
    func reloadData()
}

protocol NewChallengePresenter{
    
    func getChallengeHeader(challenge: Challenge)
    func getChallengeImages(challengeID: String)
    func sendPhotoToCloudinary(infoImage: UIImage, challengeID: String)

}

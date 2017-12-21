//
//  NewChallengeProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol NewChallengeView{
    func setHeader(theme: String, mainImageURL: String,numPhotos: Int)
    func setHeaderStatusAsFinished(winner: User, photoWinner: Photo)
    func setHeaderStatusAsTimer(endDate: Date)
    func setHeaderButtonAsParticipating()
    func setUserLoggedIn(isLogged: Bool)
    func setFeaturedCollectionMyFavoriteClick(myFavoriteClick: Photo?)
    func setFeaturedCollectionMyClick(myClick: Photo?)
    func setChallengePhotos(photos: [Photo])
    func showCollectionPhotos()
}

protocol NewChallengePresenter{
    
    func getChallengeHeader(challengeID: String, challengeState: ChallengeState)
    func getChallengeImages(challengeID: String)

}

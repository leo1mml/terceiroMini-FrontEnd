//
//  NewChallengePresenterImpl.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class NewChallengePresenterImpl: NewChallengePresenter{
    

    
    
    init(challengeView view: NewChallengeView) {
        self.view = view
    }
    
    var view : NewChallengeView
    
    func getChallengeHeader(challengeID: String, challengeState: ChallengeState) {
        
        
        NetworkManager.getChallengeById(id: challengeID) { (challenge, error) in
            if(error != nil){
                print("Cant find challenge")
            }else{
         
                self.view.setHeader(theme: (challenge?.theme)!, mainImageURL: (challenge?.imageUrl)!, numPhotos: (challenge?.numPhotos)!)
                
                if challenge?.numPhotos != 0{
                    self.getFeaturedCollectionHeader(challengeID: challengeID)
                }
                switch challengeState {
                case .open:
                    //timer
                    self.view.setHeaderStatusAsTimer(endDate: (challenge?.endDate)!)
                    self.verifyIfUserHasPhoto(challengeID: challengeID)
                    
                    break
                case .finished:
                    
                  //  self.view.setHeaderStatusAsFinished(winner: <#T##User#>, photoWinner: <#T##Photo#>)
                    break
                default:
                    break
                }

            }
        }
    }
    
    func verifyIfUserHasPhoto(challengeID: String){
        if let token = UserDefaults.standard.string(forKey: "token"){
            NetworkManager.getMyClick(byChallengeId: challengeID, token: token, completion: { (photo, error) in
                if error == nil{
                    self.view.setHeaderButtonAsParticipating()
                }
            })
        }
        
        
    }
    
    func getFeaturedCollectionHeader(challengeID: String) {
        

        if let token = UserDefaults.standard.string(forKey: "token"){

            self.view.setUserLoggedIn(isLogged: true)

            NetworkManager.getMyFavouriteClick(byChallengeId: challengeID, token: token, completion: { (photo, error) in
                if (photo != nil){
                    self.view.setFeaturedCollectionMyFavoriteClick(myFavoriteClick: photo)
                }else{
                    self.view.setFeaturedCollectionMyFavoriteClick(myFavoriteClick: nil)
                    //print(error)
                }
            })

            NetworkManager.getMyClick(byChallengeId: challengeID, token: token, completion: { (photo, error) in
                if (photo != nil){
                    self.view.setFeaturedCollectionMyClick(myClick: photo!)
                }else{
                    self.view.setFeaturedCollectionMyClick(myClick: nil)
                }
            })
        }

    }
    
    func getChallengeImages(challengeID: String) {
        
        
        NetworkManager.getPhotos(byChallengeId: challengeID) { (photos, error) in
            
            if let err = error {
                print(err)
                return
            }
            
            self.view.setChallengePhotos(photos: photos!)
            DispatchQueue.main.async {
                self.view.showCollectionPhotos()
            }
        }
        
    }
    
    

}


//
//  NewChallengePresenterImpl.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import Cloudinary
class NewChallengePresenterImpl: NewChallengePresenter{
    

    
    
    init(challengeView view: NewChallengeView) {
        self.view = view
    }
    
    var view : NewChallengeView
    
    let cloudname = "clicks"
    let apiKey = "535385847914562"
    let uploadPreset = "clicksPreset"
    
    func sendPhotoToCloudinary(infoImage: UIImage, challengeID: String) {
        let config = CLDConfiguration(cloudName: cloudname, apiKey: apiKey)
        let cloudinary = CLDCloudinary(configuration: config)
        let imageData = UIImageJPEGRepresentation(infoImage, 1.0)
        
        _ = cloudinary.createUploader().upload(data: imageData!, uploadPreset: uploadPreset, params: nil, progress: nil) {
            (result, error) in
            if (error != nil) {
                print("deu merda ao subir a foto para o cloudinary")
            }
            
            if let token = UserDefaults.standard.string(forKey: "token"){
                
                NetworkManager.getUser(byToken: token, completion: { (user, error) in
                    if (user != nil){
                        let photo = Photo(nil,result?.url,(user?.id)!,challengeID, nil)
                        NetworkManager.addPhoto(photo, completion: { (photo, error) in
                            
                            if (error != nil){
                                print("deu merda na hora enviar a foto pro banco")
                            }
                            
                            self.getChallengeImages(challengeID: challengeID)
                            self.view.setHeaderButtonAsParticipating()
                            
                        })
                    }
                })
            }
        }
    }
    
    func getChallengeHeader(challengeID: String, challengeState: ChallengeState) {
        
        if UserDefaults.standard.string(forKey: "token") != nil{
            self.view.setUserLoggedIn(isLogged: true)
        }else{
            self.view.setUserLoggedIn(isLogged: false)
        }
        
        
        NetworkManager.getChallengeById(id: challengeID) { (challenge, error) in
            if(error != nil){
                print("Cant find challenge")
            }else{
         
                self.view.setHeader(theme: (challenge?.theme)!, mainImageURL: (challenge?.imageUrl)!, numPhotos: (challenge?.numPhotos)!)
                
                if challenge?.numPhotos != 0{
                    self.getFeaturedCollectionHeader(challengeID: challengeID)
                    self.view.showFeaturedCollectionView()
                }
                switch challengeState {
                case .open:
                    //timer
                    self.view.setHeaderStatusAsTimer(endDate: (challenge?.endDate)!)
                    self.verifyIfUserHasPhoto(challengeID: challengeID)
                    
                    break
                case .finished:
                    NetworkManager.getChallengeWinner(by: challengeID, completion: { (user, error) in
                        if(error != nil){
                            return
                        }
                        self.view.setHeaderStatusAsFinished(winner: user!, photoWinner: Photo("", "", "", "", [""]))
                    })
                    break
                case .notLogged:
                    self.view.setHeaderStatusAsTimer(endDate: (challenge?.endDate)!)
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
                    if(photo == nil){
                        self.view.setHeaderButtonAsParticipate()
                    }else {
                        self.view.setHeaderButtonAsParticipating()
                    }
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


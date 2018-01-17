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
                            self.view.setState(state: .participating)
                            self.getChallengeImages(challengeID: challengeID)
                            self.getFeaturedCollectionHeader(challengeID: challengeID)
                        })
                    }
                })
            }
        }
    }
    
    func getChallengeHeader(challenge: Challenge) {
        
        getChallengeImages(challengeID: challenge.id)
        
        if(UserDefaults.standard.string(forKey: "token") == nil){
            self.view.setState(state: .notLogged)
            return
        }
        getFeaturedCollectionHeader(challengeID: challenge.id)
    }
    
    func getFeaturedCollectionHeader(challengeID: String) {
        

        if let token = UserDefaults.standard.string(forKey: "token"){

            self.view.setUserLoggedIn(isLogged: true)

            NetworkManager.getMyFavouriteClick(byChallengeId: challengeID, token: token, completion: { (photo, error) in
                if(error == nil && photo != nil){
                    self.view.setFeaturedCollectionMyFavoriteClick(myFavoriteClick: photo)
                    self.view.reloadData()
                    return
                }
                self.view.setFeaturedCollectionMyFavoriteClick(myFavoriteClick: nil)
                self.view.reloadData()
            })

            NetworkManager.getMyClick(byChallengeId: challengeID, token: token, completion: { (photo, error) in
                if(error == nil && photo != nil){
                    self.view.setFeaturedCollectionMyClick(myClick: photo!)
                    self.view.setState(state: .participating)
                    self.view.reloadData()
                    return
                }
                self.view.setFeaturedCollectionMyClick(myClick: nil)
                self.getChallengeImages(challengeID: challengeID)
                self.view.setState(state: .open)
                self.view.reloadData()
                return
            })
        }
        self.view.setUserLoggedIn(isLogged: false)

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


//
//  ChallengePresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 20/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Cloudinary

class ChallengePresenterImpl: ChallengePresenter{
    
    
    
    init(challengeView view: ChallengeView) {
        self.view = view
    }
    
    var view : ChallengeView
    
    let cloudname = "clicks"
    let apiKey = "535385847914562"
    let uploadPreset = "clicksPreset"
    //cloudinary
    
    func sendPhotoToCloudinary(infoImage: UIImage, challengeID: String) {
        let config = CLDConfiguration(cloudName: cloudname, apiKey: apiKey)
        let cloudinary = CLDCloudinary(configuration: config)
        let imageData = UIImageJPEGRepresentation(infoImage, 1.0)
        //        let retorno = cloudinary.createUploader().upload(data: imageData!, uploadPreset: uploadPreset)
        
        //view.startWating(msg: "Wait for yout photo to upload!")
        
        let retorno = cloudinary.createUploader().upload(data: imageData!, uploadPreset: uploadPreset, params: nil, progress: nil) {
            (result, error) in
            if (error != nil) {
                print("deu merda ao subir a foto para o cloudinary")
            }
            let ownerID = "5a26fcfd47075500141f9250"
            
            let photo = Photo(nil,result?.url,ownerID,challengeID, 0)
            NetworkManager.addPhoto(photo, completion: { (photo, error) in
                
                if (error != nil){
                    print("deu merda na hora enviar a foto pro banco")
                }
                
                self.getChallengeImages(challengeID: challengeID)
                
            })
            
        }
        
        
        print(retorno)
        
        
    }
    
    
    func getChallengeHeader(challengeID: String) {
        
       
        NetworkManager.getChallengeById(id: challengeID, completion: { (challenge, error) in
            
            if((error) != nil){
                print("Challenge não encontrado")
            }
            DispatchQueue.main.async {
                self.view.setHeader(theme: (challenge?.theme)!, endDate: (challenge?.endDate)!, mainImageURL: (challenge?.imageUrl)!, numPhotos: (challenge?.numPhotos)! )
                if(challenge?.numPhotos != 0){
                    self.view.showFeaturedCollectionView()
                    
                }else{
                    self.view.showNoImagesWarning()
                }
                self.setChallengeState(challenge: challenge!)
                
            }
            
            
        })
        
    }
    
    func getChallengeImages(challengeID: String) {
        
        //   var photos : [Photo]!
        
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
    
    func setChallengeState(challenge: Challenge) {
        
        if challenge.isHappening{
            view.setChallengeState(state: ChallengeState.open)
        }else{
            view.setChallengeState(state: ChallengeState.finished)
            let winner = getChallengeWinner(challengeID: challenge.id)
            view.showChallengeWinner(winner: winner)
        }
        
    }
    
    func getChallengeState(challenge: Challenge) -> ChallengeState{
        if challenge.isOver{
            return ChallengeState.finished
        }else{
            return ChallengeState.open
        }
        
    }
    func getChallengeWinner(challengeID: String) -> User{
        //pegar challenge winner
        
        return User("aaa", "", "","", "")
    }
    
    //MAIN BUTTON HANDLE CLICK
    func mainButtonClicked() {
       
        view.showPhotoMenu()
    }
    
    func presentProfile(challengeID: String) {
        //let user = getChallengeWinner(challengeID: challengeID)
        //IR PARA TELA
    }
    
    func expandPhoto(photos: [String]) {
        //view.goToExpandoPhotoView(parameter: <#T##([String], Int)#>)
    }
    
}


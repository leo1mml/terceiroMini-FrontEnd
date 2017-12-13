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
        
        let retorno = cloudinary.createUploader().upload(data: imageData!, uploadPreset: uploadPreset, params: nil, progress: nil) {
            (result, error) in
            if (error != nil) {
                print("deu merda ao subir a foto para o cloudinary")
            }
            let ownerID = "5a21a303391838001482d1f2"
            
            let photo = Photo(nil,result?.url,ownerID,challengeID, 0)
            NetworkManager.addPhoto(photo, completion: { (photo, error) in
                if (error != nil){
                    print("deu merda na hora enviar a foto pro banco")
                }
                
            })
            //MANDA PARA O BANCO
            // var photo = Photo(nil,result?.url,UserDefaults.standard (ISSO É O TOKEN) )
            // NetworkManager.addPhoto( , completion: )
            //print(result)
        }
        
        
        print(retorno)
        
        
    }
    
    
    func getChallengeHeader(challengeID: String) {
        
        
        NetworkManager.getChallengeById(id: challengeID, completion: { (challenge, error) in
            
            if((error) != nil){
                print("Challenge não encontrado")
            }
            
            self.view.setHeader(theme: (challenge?.theme)!, endDate: (challenge?.endDate)!, mainImageURL: (challenge?.imageUrl)!, numPhotos: (challenge?.numPhotos)! )
            
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
        }
        
    }
    
    func getChallengeState(challenge: Challenge) {
        
        if challenge.isHappening{
            view.setChallengeState(state: ChallengeState.open)
        }else{
            view.setChallengeState(state: ChallengeState.finished)
        }
        
    }
    
    
    
    func mainButtonClicked() {
        view.showPhotoMenu()
    }
    
    
}


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
    
    func sendPhotoToCloudinary(infoImage: UIImage) {
        let config = CLDConfiguration(cloudName: cloudname, apiKey: apiKey)
        let cloudinary = CLDCloudinary(configuration: config)
        let imageData = UIImageJPEGRepresentation(infoImage, 1.0)
//        let retorno = cloudinary.createUploader().upload(data: imageData!, uploadPreset: uploadPreset)
    
        let retorno = cloudinary.createUploader().upload(data: imageData!, uploadPreset: uploadPreset, params: nil, progress: nil) {
            (result, error) in
            if let error = error {
                print(error)
            }
            
            //MANDA PARA O BANCO
            
            //print(result)
        }
        
        
        print(retorno)
        
        
    }
    
    func getChallengeTimer() {
        
    }
    
    func mainButtonClicked() {
        view.showPhotoMenu()
    }
    
    
}


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
    
    
    
    var view : ChallengeView?
    
    let cloudname = "clicks"
    let apiKey = "535385847914562"
    let uploadPreset = "clicksPreset"
    //cloudinary
    
    func sendPhotoToCloudinary(infoImage: UIImage) {
        let config = CLDConfiguration(cloudName: cloudname, apiKey: apiKey)
        let cloudinary = CLDCloudinary(configuration: config)
        let imageData = UIImagePNGRepresentation(infoImage)
        let url = cloudinary.createUrl()
        let imageUrl = url.generate()
        
        
    
        let uploader = cloudinary.createUploader()
        uploader.upload(data: imageData!, uploadPreset: uploadPreset) { (result, error) in
            print(result)
        }
        
        
    }
    
    func getChallengeTimer() {
        
    }
    
//    func configureCloudinary(){
//        let params = CLDUploadRequestParams()
//        let trans = CLDTransformation().setCrop("limit").setTags("samples").setWidth(3000).setHeight(2000)
//        params.setTransformation([trans])
//        cloudinary.createUploader().upload(url: "sample.jpg",  params: params)
//            .response({ (resultRes, errorRes) in
//                print(resultRes)
//            })
//    }
    
}


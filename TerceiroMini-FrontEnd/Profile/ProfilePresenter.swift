//
//  PerfilPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 16/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

class ProfilePresenterImpl: ProfilePresenter {
    func loadImages() {
        
    }
    

    var view: ProfileView?
    
    init(profileView: ProfileView) {
        self.view = profileView
    }
    
    func methods() {
        let tkn = ""
        
        NetworkManager.getPhotos(byToken: tkn) { (pht, err) in
            
            guard err == nil else {
                
                // view.mostraMensagemQueDeuRuim()
                
                return
            }
            
            // view.pegaAquiAsFotos(pht)
        }
    }
    
//    func loadImages() {
//        //let token = UserDefaults.standard.
//        let token = ""
//        var images = [UIImage]()
//
//        NetworkManager.getPhotos(byToken: token) { (photos, err) in
//
//            guard err == nil else {
//
//                self.view?.erroLoadImages()
//
//                return
//            }
//
//            for photo in photos! {
//
//                UIImage.fetch(with: photo.url!, completion: { (image) in
//                    images.append(image)
//                })
//
////                NetworkManager.getChallenge(completion: { (challenge, err) in
//
//                }, photo.challengeId)
//
//            }
//
//            self.view?.receiveImages(images: images)
//        }
//    }
}

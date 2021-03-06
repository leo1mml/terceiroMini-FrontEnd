 //
//  ChallengeClosedPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import Cloudinary

class ChallengeClosedPresenterImpl: ChallengeClosedPresenter {
    
    var view: ChallengeClosedView?
    var id: String?
    
    init(challengeClosedView: ChallengeClosedView) {
        self.view = challengeClosedView
    }
    
    func showReport() {
        view?.showAlert()
    }
    
    func excludePhoto() {
        NetworkManager.deletePhoto(byId: id!) { (photo, error) in
            guard photo != nil else {
                return
            }
            self.view?.dissmissAndReloadParent()
        }
        
    }
    
    func separateIdFromUrl(url: String) -> String{
        let sufix = url.suffix(24)
        let prefixSufix = sufix.prefix(20)
        return String(prefixSufix)
    }
    
    func vote(photo: Photo) {
        
        if let token = UserDefaults.standard.string(forKey: "token"){
            NetworkManager.voteOnPhoto(byId: photo.id!, token: token, completion: { (complete) in
                if (complete){
                    self.view?.enableMyFavoriteClickChosebuttonLabel()
                }
            })
        }
        
    }
    
    func unvote(photo: Photo) {
        if let token = UserDefaults.standard.string(forKey: "token"){
            NetworkManager.unvotePhoto(byId: photo.id!, token: token, completion: { (complete) in
                if(complete){
                    self.view?.enableChoseClickButton()
                }
            })
        }
    }
    
    func checkIfChosenClick(currentPhoto: Photo) {
        
        //se for o click dele
       
        if let token = UserDefaults.standard.string(forKey: "token"){
            NetworkManager.getMyFavouriteClick(byChallengeId: currentPhoto.challengeId, token: token, completion: { (photo, error) in
                if photo != nil{
                    if(currentPhoto.id == photo?.id){
                        self.view?.enableMyFavoriteClickChosebuttonLabel()
                    }
                    
                }else{
                    self.view?.enableChoseClickButton()
                }
            })
            NetworkManager.getMyClick(byChallengeId: currentPhoto.challengeId, token: token, completion: { (photo, error) in
                if photo != nil{
                    
                    if currentPhoto.ownerId == photo?.ownerId{
                        self.view?.enableMyClickChosebuttonLabel()
                        self.id = currentPhoto.id
                    }
                }
            })
            
        }
        
    }

}

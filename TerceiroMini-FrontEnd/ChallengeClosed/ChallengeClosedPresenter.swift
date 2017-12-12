//
//  ChallengeClosedPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class ChallengeClosedPresenterImpl: ChallengeClosedPresenter {
    
    
    
    var view: ChallengeClosedView?
    
    init(challengeClosedView: ChallengeClosedView) {
        self.view = challengeClosedView
    }
    
    func showReport() {
        view?.showAlert()
    }
    
    func chooseClick(photo: Photo) {
        
        //se não for meu click
        
            if let token = UserDefaults.standard.string(forKey: "token"){
                NetworkManager.voteOnPhoto(byId: photo.id!, token: token, completion: { (complete) in
                    if (complete){
                        self.view?.enableMyClickChosebuttonLabel()
                    }else{
                        //erro
                    }
                })
            }
    }
    
    func checkIfChosenClick(currentPhoto: Photo) {
        
        //se for o click dele
       
        if let token = UserDefaults.standard.string(forKey: "token"){
            NetworkManager.getMyClick(byChallengeId: currentPhoto.challengeId, token: token, completion: { (photos, error) in
                if photos != nil{
                    if(currentPhoto.id == photos?.first?.id){
                        self.view?.enableMyClickChosebuttonLabel()
                    }else{
                        self.view?.enableChoseClickButton()
                    }
                    
                }else{
                    self.view?.enableChoseClickButton()
                }
            })
        }
    }

}

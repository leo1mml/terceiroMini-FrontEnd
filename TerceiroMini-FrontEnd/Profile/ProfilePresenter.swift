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
    
    func loadPhotos(id: String) {
        NetworkManager.getUserPhotos(byUserId: id) { (photos, err) in
            guard err == nil else {
                
                return
            }
            
            self.view?.receivePhotos(photos: photos!)
            
        }
    }
    
    func loadData(id: String) {
        
        var cells = [ProfileCellHolder]()
        
        NetworkManager.getUserPhotos(byUserId: id) { (photos, err) in
            guard err == nil else {
                
                 return
            }
            
            for index in 0..<photos!.count{
                NetworkManager.getChallengeById(id: photos![index].challengeId, completion: { (challenge, err) in
                    guard err == nil else {
                        
                        return
                    }
                    
                    UIImage.fetch(with: photos![index].url!, completion: { (image) in
                        let profileCell = ProfileCellHolder(image: image, theme: (challenge?.theme)!, isWinner: challenge?.winner == photos![index].url)
                        cells.append(profileCell)
                        self.view?.receiveCells(cells: cells)
                    })
                    
                })
            }
        }
    }

    func loadHeader(id: String) {

        var profileHolder = ProfileUserHolder(image: UIImage(), name: "", username: "")
        
        NetworkManager.getUser(byId: id) { (user, error) in
            
            guard error == nil else {
                
                return
            }
            
            // Usuario
            
            if user?.profilePhotoUrl != nil {
                
                UIImage.fetch(with: (user?.profilePhotoUrl)!) { (image) in
                    // ImagemPerfil
                    
                    profileHolder = ProfileUserHolder(image: image, name: (user?.name)!, username: (user?.username) ?? "no user name")
                    self.view?.receiveDatas(profileUserHolder: profileHolder)
                }
                
            } else {
                
                let image = UIImage(named: "profile-default")!
                profileHolder = ProfileUserHolder(image: image, name: (user?.name)!, username: (user?.username)!)
                self.view?.receiveDatas(profileUserHolder: profileHolder)
            }
        }
    }
}

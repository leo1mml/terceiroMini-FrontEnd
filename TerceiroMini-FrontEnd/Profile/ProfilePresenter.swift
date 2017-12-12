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
    
    func loadData(id: String) {
        var cells = [ProfileCellHolder]()
        var amountPhotos = 0
        var amountTrophy = 0
        
        NetworkManager.getUserPhotos(byUserId: id) { (photos, error) in
            
            guard error == nil else {
                
                return
            }
            
            // fotos do usuario
            
            // passo fotos para images
            for photo in photos! {
                amountPhotos += 1
                NetworkManager.getChallengeById(id: photo.challengeId) { (challenge, error) in
                    
                    guard error == nil else {
                        
                        return
                    }
                    
                    // Challenge
                    if challenge?.winner == photo.ownerId {
                        amountTrophy += 1
                    }
                    
                    // montagem da cell
                    UIImage.fetch(with: photo.url!, completion: { (image) in
                        let profileCell = ProfileCellHolder(image: image, theme: (challenge?.theme)!, isWinner: challenge?.winner == photo.url)
                        cells.append(profileCell)
                        self.view?.receiveCells(cells: cells)
                        self.loadHeader(id: id, amountPhotos: amountPhotos, amountTrophy: amountTrophy)
                    })
                }
            }
            
            
        }
    }
    
    func loadHeader(id: String, amountPhotos: Int, amountTrophy: Int) {

        var profileHolder = ProfileUserHolder(image: UIImage(), name: "", username: "", amountPhotos: 0, amountTrophy: 0)
        
        NetworkManager.getUser(byId: id) { (user, error) in
            
            guard error == nil else {
                
                return
            }
            
            // Usuario
            
            if user?.profilePhotoUrl != nil {
                
                UIImage.fetch(with: (user?.profilePhotoUrl)!) { (image) in
                    // ImagemPerfil
                    
                    profileHolder = ProfileUserHolder(image: image, name: (user?.name)!, username: (user?.username)!, amountPhotos: amountPhotos, amountTrophy: amountTrophy)
                    self.view?.receiveDatas(profileUserHolder: profileHolder)
                }
                
            } else {
                
                let image = UIImage()
                profileHolder = ProfileUserHolder(image: image, name: (user?.name)!, username: (user?.username)!, amountPhotos: amountPhotos, amountTrophy: amountTrophy)
                self.view?.receiveDatas(profileUserHolder: profileHolder)
            }
        }
    }
}

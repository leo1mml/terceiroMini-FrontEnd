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
        var profileHolder = ProfileUserHolder(image: UIImage(), name: "", username: "", amountPhotos: 0, cellHolders: cells)
        
        NetworkManager.getUser(byId: id) { (user, error) in
            
            guard error == nil else {
                
                return
            }
            
            // Usuario
            
            UIImage.fetch(with: (user?.profilePhotoUrl)!) { (image) in
                // ImagemPerfil
                
                NetworkManager.getUserPhotos(byUserId: id) { (photos, error) in
                    
                    guard error == nil else {
                        
                        return
                    }
                    
                    // fotos do usuario
                    
                    // passo fotos para images
                    for photo in photos! {
                        
                        NetworkManager.getChallengeById(id: id) { (challenge, error) in
                            
                            guard error == nil else {
                                
                                return
                            }
                            
                            // Challenge
                            
                            // montagem da cell
                            UIImage.fetch(with: photo.url!, completion: { (image) in
                                let profileCell = ProfileCellHolder(image: image, theme: (challenge?.theme)!, isWinner: challenge?.winner == photo.url)
                                cells.append(profileCell)
                            })
                        }
                    }

                }
                profileHolder = ProfileUserHolder(image: image, name: (user?.name)!, username: (user?.username)!, amountPhotos: cells.count, cellHolders: cells)
                self.view?.receiveDatas(profileUserHolder: profileHolder)
            }
        }
    }
}

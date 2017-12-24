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
    
    func loadData(id: String, photos: [Photo]) {
        
        var cells = [ProfileCellHolder]()
        
        for index in 0..<photos.count{
            cells.append(ProfileCellHolder(theme: "", isWinner: false))
            NetworkManager.getChallengeById(id: photos[index].challengeId, completion: { (challenge, err) in
                guard err == nil else {
                    
                    return
                }
                
                    let profileCell = ProfileCellHolder(theme: (challenge?.theme)!, isWinner: challenge?.winner == photos[index].url)
                    cells[index] = profileCell
                    self.view?.receiveCells(cells: cells)
 
            })
        }
    }

    func loadHeader(id: String) {
        
        var profileHolder = ProfileUserHolder(imageUrl: "", name: "", username: "")
        
        NetworkManager.getUser(byId: id) { (user, error) in
            
            guard error == nil else {
                
                return
            }
            
            // Usuario
            
            profileHolder = ProfileUserHolder(imageUrl: (user?.profilePhotoUrl)!, name: (user?.name)!, username: (user?.userName) ?? "no user name")
            self.view?.receiveDatas(profileUserHolder: profileHolder)
            
        }
    }
}

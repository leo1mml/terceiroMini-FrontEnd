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
    
    func loadImages() {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1YTI2ZmNmZDQ3MDc1NTAwMTQxZjkyNTAiLCJhY2Nlc3MiOiJhdXRoIiwiaWF0IjoxNTEyNTA0NTczfQ.0nSNkA6tOIxloWyfnFSQh6G0dIzkRPTJssLCvWp7gDk"
        var currentUser: User!
        var currentPhotos: [Photo]!
        let profileHolder: ProfileUserHolder
        var profileCellHolders = [ProfileCellHolder]()
        var photoUserProfile: UIImage!
        
        NetworkManager.getUser(byToken: token) { (user, error) in
            
            guard error == nil else {
                
                return
            }
            
            currentUser = user
        }
        NetworkManager.getPhotos(byToken: token) { (photos, err) in
            
            guard err == nil else {
                
                return
            }
            
            currentPhotos = photos
        }
        
        for photo in currentPhotos {
            
            var currentImage: UIImage!
            var theme: String!
            
            UIImage.fetch(with: photo.url!, completion: { (image) in
                currentImage = image
            })
            
            NetworkManager.getChallengeById(id: photo.challengeId, completion: { (challenge, error) in
                guard error == nil else {
                    theme = challenge?.theme
                    // erro
                    return
                }
                
                var profileCellHolder = ProfileCellHolder(image: currentImage, theme: theme, isWinner: false)
                
                if let winner = challenge?.winner {
                    profileCellHolder.isWinner = photo.ownerId == winner
                }
                
                profileCellHolders.append(profileCellHolder)
                
            })
            
        }
        
        UIImage.fetch(with: currentUser.profilePhotoUrl!, completion: { (image) in
            photoUserProfile = image
        })
        
        profileHolder = ProfileUserHolder(image: photoUserProfile, name: currentUser.name, username: currentUser.username, amountPhotos: currentPhotos.count, cellHolders: profileCellHolders)
        
        view?.receiveDatas(profileUserHolder: profileHolder)
        
    }
}

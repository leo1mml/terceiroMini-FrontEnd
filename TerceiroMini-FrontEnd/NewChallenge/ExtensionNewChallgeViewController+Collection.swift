//
//  ExtensionNewChallgeViewController+Collection.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

extension NewChallengeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengePhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.cellImage.layer.cornerRadius =  (cell.cellImage.frame.size.width / 10)/2
        
        switch state {
            
        case .finished?:
            cell.numberOfVotes.isHidden = false
            //cell.statusLabel.isHidden = false
            cell.usernameLabel.isHidden = false
            cell.usernamePhoto.isHidden = false
            cell.clicksLogo.isHidden = false
            break
        default:
            
            break
        }
        
        let url = URL(string: (challengePhotos?[indexPath.row].url!)!)
        getImageFromUrl(imageURL: url, newImage: cell.cellImage)
        //quebrei o MVP, depois vou arrumar.
        NetworkManager.getUser(byId: (challengePhotos?[indexPath.row].ownerId)!) { (user, error) in
            if error != nil{
                print("não consegui pegar o dono da foto")
            }else{
                cell.usernameLabel.text = user?.name
                if(user?.profilePhotoUrl != nil){
                    let userPhotoUrl = URL(string: (user?.profilePhotoUrl)!)
                    self.getImageFromUrl(imageURL: userPhotoUrl, newImage: cell.usernamePhoto)
                }

            }
        }
        cell.numberOfVotes.text = (String(describing: challengePhotos?[indexPath.row].votes?.count))
        
      
        
        
        //cell.usernameLabel.text = challengePhotos?[indexPath.row].ownerId
        //        cell.usernameLabel.text = "aaa.aaa"
        //  cell.usernamePhoto.image = UIImage(named: "imagem1")
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderIdentifier", for: indexPath) as! NewHeaderChallengeCollectionReusableView
        
        header.addGradientToChallengeMainImage()
        
        
        return header
    }
    
    
    func getImageFromUrl(imageURL: URL!, newImage: UIImageView ){
        
        
        var imageFromURL = UIImage()
        if let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    if imageData != nil {
                        imageFromURL = UIImage(data: imageData! as Data)!
                        newImage.image = imageFromURL
                        
                    }
                }
            }
            
        }
    }
    
    
    
    
}

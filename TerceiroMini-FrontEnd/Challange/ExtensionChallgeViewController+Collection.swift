//
//  ExtensionChallgeViewController+Collection.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 23/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit


extension ChallengeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.challengePhotos?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.cellImage.layer.cornerRadius =  (cell.cellImage.frame.size.width / 10)/2
        
        switch state {
   
        case .finished:
            cell.numberOfVotes.isHidden = false
            cell.statusLabel.isHidden = false
            cell.usernameLabel.isHidden = false
            cell.usernamePhoto.isHidden = false
            cell.clicksLogo.isHidden = false
            break
        default:
            
            break
        }
        
        let url = URL(string: (challengePhotos?[indexPath.row].url!)!)
        getImageFromUrl(imageURL: url, newImage: cell.cellImage)
          //cell.statusLabel.text = "vencedor"
//        cell.usernameLabel.text = "aaa.aaa"
      //  cell.usernamePhoto.image = UIImage(named: "imagem1")
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderIdentifier", for: indexPath) as! HeaderChallengeCollectionReusableView
        
        header.delegate = self
        header.dataSource = self
        
        header.addGradientToChallengeMainImage()
    
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let photoID = self.challengePhotos![indexPath.row].id
        data = (self.challengePhotos, indexPath.row) as? ([Photo], Int)
        self.goToExpandoPhotoView(parameter: data!)
         //let photo = self.challengePhotos[indexPath.row]
        
    }
    
    
    func getImageFromUrl(imageURL: URL!, newImage: UIImageView ){

        
        var imageFromURL = UIImage()
        if let url = imageURL {
            //All network operations has to run on different thread(not on main thread).
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                //All UI operations has to run on main thread.
                DispatchQueue.main.async {
                    if imageData != nil {
                        imageFromURL = UIImage(data: imageData! as Data)!
                        newImage.image = imageFromURL
                        //self.mainCollectionView.reloadData()
                    }
                }
            }

        }
    }
//
    
}

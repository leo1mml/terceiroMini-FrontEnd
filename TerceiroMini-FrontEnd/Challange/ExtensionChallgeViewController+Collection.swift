//
//  ExtensionChallgeViewController+Collection.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 23/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit
extension ChallengeViewController {
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if collectionView == self.featuredCollectionView{
         //   return imageSampleLink.count
        //}else{
            return 50
       // }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == self.featuredCollectionView{
//            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredPhotoCell", for: indexPath) as! FeaturedFavoriteClickCollectionViewCell
//                let imageURL = URL(string: imageSampleLink[indexPath.row])
//
//                getImageFromUrl(imageURL: imageURL!, newImage: cellA.cellImage)
//
//
//            return cellA
//        }else{
           // let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPhotoCell", for: indexPath) as! MainCollectionViewCell
           // let imageURL = URL(string: imageSampleLink.first!)
        //    cellB.numberOfVotes.text = "333"
           // getImageFromUrl(imageURL: imageURL, newImage: cellB.cellImage!)
          //  return cellB
//        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
    //    cell.cellImage.image = UIImage(named: "imagem1")
          cell.numberOfVotes.text = "111"
          //cell.statusLabel.text = "vencedor"
//        cell.usernameLabel.text = "aaa.aaa"
      //  cell.usernamePhoto.image = UIImage(named: "imagem1")
        
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderIdentifier", for: indexPath) as! HeaderChallengeCollectionReusableView
        return header
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
                    }
                }
            }

        }
    }
//
    
}

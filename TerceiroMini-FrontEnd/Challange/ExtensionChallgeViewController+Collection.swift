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
        if collectionView == self.featuredCollectionView{
            return imageSampleLink.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.featuredCollectionView{
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredPhotoCell", for: indexPath) as! FeaturedCollectionViewCell
                let imageURL = URL(string: imageSampleLink[indexPath.row])
            getImageFromUrl(imageURL: imageURL!, newImage: cellA.image!)
            
            

//            var imageFromURL = UIImage()
//            if let url = imageURL {
//                //All network operations has to run on different thread(not on main thread).
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let imageData = NSData(contentsOf: url)
//                    //All UI operations has to run on main thread.
//                    DispatchQueue.main.async {
//                        if imageData != nil {
//                            imageFromURL = UIImage(data: imageData! as Data)!
//                            cellA.image.image = imageFromURL
//                        }
//                    }
//                }
//
//            }
            
            
     
            
            return cellA
        }else{
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPhotoCell", for: indexPath)
            return cellB
        }
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

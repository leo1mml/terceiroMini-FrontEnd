//
//  ExtensionChallgeViewController+Collection.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 23/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit
extension ChallengeViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    
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
            let url = URL(string: "http://res.cloudinary.com/clicks/image/upload/v1511463622/a4ez1dbhxfwz9l4lejvt.jpg")
            let data = try? Data(contentsOf: url!)
            
//            let url = URL(string: self.imageSampleLink[indexPath.row])
//
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                DispatchQueue.main.async {
//                    cellA.image.image = UIImage(data: data!)
//                }
//            }
            
            
            
            cellA.image.image = UIImage(data: data!)
            
            return cellA
        }else{
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPhotoCell", for: indexPath)
            return cellB
        }
    }
    
    
}

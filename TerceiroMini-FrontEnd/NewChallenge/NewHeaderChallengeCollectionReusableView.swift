//
//  NewHeaderChallengeCollectionReusableView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit



class NewHeaderChallengeCollectionReusableView: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet var featuredCollectionView: UICollectionView!
    @IBOutlet var challengeLabel: UILabel!
    @IBOutlet var numberOfPhotos: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusImage: UIImageView!
    @IBOutlet var mainButton: LeftAlignedIconButton!
    
    var myClick : Photo?
    var myFavoriteClick : Photo?
    var cellFavoriteClickFilledFlag = false
    
    
    override func awakeFromNib() {
        initNibs()
        
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        
        
    }
    
    func initNibs(){
        self.featuredCollectionView.register(UINib(nibName: FeaturedMyClickCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeaturedMyClickCollectionViewCell.identifier)
        self.featuredCollectionView.register(UINib(nibName: FeaturedFavoriteClickCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeaturedFavoriteClickCollectionViewCell.identifier)
    }
    
    func addGradientToChallengeMainImage(){

        let startingGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
        let middleGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:0.6)
        let endGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:0.4)
        
        mainImage.layer.sublayers = nil
        mainImage.addChallengeGradientLayer(frame: mainImage.bounds, colors: [startingGradientColor, middleGradientColor,endGradientColor,Colors.darkWhite])
    }
    
    
    //MARK - Featured Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItens = 0
        if myClick != nil{
            numberOfItens += 1
        }
        if myFavoriteClick != nil {
            numberOfItens += 1
        }
        return numberOfItens
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.numberOfItems(inSection: 0) ==  1{
            
            if (myFavoriteClick != nil){
                let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedFavoriteClickCollectionViewCell.identifier, for: indexPath) as! FeaturedFavoriteClickCollectionViewCell

                
                UIImage.fetch(with: (self.myFavoriteClick?.url)!, completion: { (image) in
                    cellA.cellImage.image = image
                })
                
                return cellA
            }else{
                
                let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedMyClickCollectionViewCell.identifier, for: indexPath) as! FeaturedMyClickCollectionViewCell
                cellB.cellImage.layer.cornerRadius =  cellB.cellImage.frame.size.width / 10
                
                UIImage.fetch(with: (self.myClick?.url)!, completion: { (image) in
                    cellB.cellImage.image = image
                })
                
                if (myClick?.votes?.count == 0){
                    cellB.clicks.text = "0"
                }else{
                    cellB.clicks.text = String(describing: myClick!.votes!.count)
                }
                
                
                return cellB
            }
            
        }else{
            
            if (indexPath.row == 1){
                let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedFavoriteClickCollectionViewCell.identifier, for: indexPath) as! FeaturedFavoriteClickCollectionViewCell
                
                cellA.cellImage.layer.cornerRadius = 10
                cellA.cellImage.clipsToBounds = true
                
                UIImage.fetch(with: (self.myFavoriteClick?.url)!, completion: { (image) in
                    cellA.cellImage.image = image
                })
                
                return cellA
            }else{
                let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedMyClickCollectionViewCell.identifier, for: indexPath) as! FeaturedMyClickCollectionViewCell
                cellB.cellImage.layer.cornerRadius =  cellB.cellImage.frame.size.width / 10
                
                UIImage.fetch(with: (self.myClick?.url)!, completion: { (image) in
                    cellB.cellImage.image = image
                })
                
                return cellB
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellCount = collectionView.numberOfItems(inSection: 0)
        let totalCellWidth = 121 * cellCount
        let totalSpacingWidth = 10 * (cellCount - 1)
        
        let leftInset = (253 - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
    
}

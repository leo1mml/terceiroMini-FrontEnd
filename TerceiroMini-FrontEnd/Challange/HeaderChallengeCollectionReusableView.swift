//
//  HeaderChallengeCollectionReusableView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 29/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

protocol ChallengeHeaderDelegate {
    
    func mainButtonClicked()
}

protocol ChallengeHeaderDataSource {
    
    var challengeState: ChallengeState { get }
    
    func getBackgroundImage() -> UIImage
    func getFeaturedPhotos() -> [UIImage]
    func getChallengeName() -> String
    func getNumberOfClicks() -> Int
   // func getMyClick() -> Photo?
   // func getMyFavoriteClick() -> Photo?
    //func getChallengeWinner() -> String
    
}


class HeaderChallengeCollectionReusableView: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let startingGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    let middleGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:0.6)
    let endGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:0.4)
    var delegate: ChallengeHeaderDelegate?
    var dataSource: ChallengeHeaderDataSource? {
        
        didSet {
            reviewState()
        }
    }
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var numberOfPhotos: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var myClick : Photo?
    var myFavoriteClick : Photo?
    var cellFavoriteClickFilledFlag = false
    
   
    @IBOutlet weak var mainButton: UIButton!
    @IBAction func mainButtonAction(_ sender: LeftAlignedIconButton) {
        delegate?.mainButtonClicked()
    }
    
    override func awakeFromNib() {
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
    
       //initializing nibs
       self.featuredCollectionView.register(UINib(nibName: FeaturedMyClickCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeaturedMyClickCollectionViewCell.identifier)
       self.featuredCollectionView.register(UINib(nibName: FeaturedFavoriteClickCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeaturedFavoriteClickCollectionViewCell.identifier)
    }
    
    func reviewState() {
        
        let state = dataSource?.challengeState
        
        switch state {
        case .votation?:
            mainButton.setTitle("PERÍODO DE VOTAÇÃO", for: .normal)
            mainButton.isEnabled = false
            statusLabel.text = "22h 11m 12s"
            
        case .finished?:
            //set winner name
            
            break
        case .open?:
            mainButton.setTitle("PARTICIPAR", for: .normal)
        case .participating?:
            mainButton.setTitle("PARTICIPANDO", for: .normal)
        default:
            challengeLabel.text = "nao tem state"
        }
    }
    
    func addGradientToChallengeMainImage(){
        mainImage.layer.sublayers = nil
        mainImage.addChallengeGradientLayer(frame: mainImage.bounds, colors: [startingGradientColor, middleGradientColor,endGradientColor,.white])
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellCount = collectionView.numberOfItems(inSection: 0)
        let totalCellWidth = 121 * cellCount
        let totalSpacingWidth = 10 * (cellCount - 1)
        
        let leftInset = (253 - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
    
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
        
        
//        if (numberOfItens == 2){
//            if (indexPath.row == 1){
//                let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedMyClickCollectionViewCell.identifier, for: indexPath) as! FeaturedMyClickCollectionViewCell
//                cellA.cellImage.layer.cornerRadius =  cellA.cellImage.frame.size.width / 10
//                return cellA
//
//            }else{
//                let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedFavoriteClickCollectionViewCell.identifier, for: indexPath) as! FeaturedFavoriteClickCollectionViewCell
//
//                cellB.cellImage.layer.cornerRadius =  cellB.cellImage.frame.size.width / 10
//
//                return cellB
//            }
//        }else if numberOfItens == 1 {
//            if featuredClick == 1
//        }
    
    
}

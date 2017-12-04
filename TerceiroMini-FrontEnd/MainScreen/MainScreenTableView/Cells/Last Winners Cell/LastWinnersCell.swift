//
//  LastWinnersCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class LastWinnersCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LastWinnersView {
    
    var presenter : LastWinnersPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastWinner", for: indexPath) as! WinnerCollectionViewCell
        cell.photoImage.image = UIImage(named: "pombo")
        cell.profilePhoto.image = UIImage(named: "pombo")
        cell.nameLabel.text = "Pombo Master"
        styleProfilePhotoImage(winnerProfilePhoto: cell.profilePhoto)
        styleWinnerImage(winnerPhoto: cell.photoImage)
        return cell
    }
    
    
    func styleWinnerImage(winnerPhoto: UIImageView) {
        winnerPhoto.layer.masksToBounds = true
        winnerPhoto.layer.cornerRadius = 10
        let blurEffect = UIBlurEffect(style: .dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = winnerPhoto.bounds
        blurEffectView.alpha = 0.4
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        winnerPhoto.addSubview(blurEffectView)
    }
    func styleProfilePhotoImage(winnerProfilePhoto: UIImageView) {
        winnerProfilePhoto.layer.masksToBounds = true
        winnerProfilePhoto.layer.cornerRadius = winnerProfilePhoto.frame.size.width/2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    

}

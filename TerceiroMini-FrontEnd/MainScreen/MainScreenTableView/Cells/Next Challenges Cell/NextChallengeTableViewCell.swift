//
//  NextChallengeTableViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class NextChallengeTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nextChallenge", for: indexPath) as! NextChallengesCollectionViewCell
        
        cell.dateLabel.text = "DATE"
        cell.themeImage.image = UIImage(named: "pombo")
        cell.themeLabel.text = "pombo"
        styleNextChallengeView(view: cell.containerView)
        
        return cell
    }
    
    func styleNextChallengeView (view: UIView) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

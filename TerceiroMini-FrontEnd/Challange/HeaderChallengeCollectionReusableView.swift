//
//  HeaderChallengeCollectionReusableView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 29/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class HeaderChallengeCollectionReusableView: UICollectionReusableView {
    
    
    let startingGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    let middleGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:0.4)
    
    
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var numberOfPhotos: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var mainButton: LeftAlignedIconButton!

    @IBAction func mainButtonAction(_ sender: LeftAlignedIconButton) {
    }
    
    
}

//
//  HeaderCollectionReusableView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 17/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var profileBorderView: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var topHeaderSpacingSmall: NSLayoutConstraint!
    
    @IBOutlet weak var profileUserName: UILabel!
    
    @IBOutlet weak var profileTrophyNumberLabel: UILabel!
    
    @IBOutlet weak var profilePhotoNumberLabel: UILabel!
    
}

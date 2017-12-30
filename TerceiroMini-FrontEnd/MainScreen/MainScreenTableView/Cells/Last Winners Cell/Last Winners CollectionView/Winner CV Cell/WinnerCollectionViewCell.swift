//
//  WinnerCollectionViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class WinnerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var photoView: UIView!
    
    var challenge : Challenge? {
        didSet {
            setupChallengeImage()
        }
    }
    var user : User? {
        didSet {
            self.nameLabel.text = user?.name ?? user?.email
            setupUserImage()
        }
    }
    
    func setupChallengeImage() {
        let url = URL(string: (self.challenge?.imageUrl)!)
        self.photoImage.sd_setImage(with: url, completed: nil)
    }
    
    func setupUserImage() {
        let url = URL(string: self.user?.profilePhotoUrl ?? "")
        self.profilePhoto.sd_setImage(with: url, completed: nil)
    }
    
}

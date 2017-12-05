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
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func setupChallengeImage() {
        if let image = imageCache.object(forKey: NSString(string: (challenge?.imageUrl)!)) {
            self.photoImage.image = image
        } else {
            DispatchQueue.main.async(execute: {
                UIImage.fetch(with: self.challenge!.imageUrl) { (image) in
                    self.photoImage.image = image
                    self.imageCache.setObject(image, forKey: NSString(string: (self.challenge?.imageUrl)!))
                }
            })
        }
    }
    
    func setupUserImage() {
        if let image = imageCache.object(forKey: NSString(string: (challenge?.imageUrl)!)) {
            self.photoImage.image = image
        } else {
            DispatchQueue.main.async(execute: {
                if let photoUrl = self.user?.profilePhotoUrl {
                    UIImage.fetch(with: photoUrl) { (image) in
                        self.profilePhoto.image = image
                        self.imageCache.setObject(image, forKey: NSString(string: (self.challenge?.imageUrl)!))
                    }
                }
            })
        }
    }
    
}

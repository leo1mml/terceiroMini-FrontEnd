//
//  NextChallengesCollectionViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class NextChallengesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var themeImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    var challenge : Challenge? {
        didSet {
            self.themeLabel.text = challenge?.theme
            setupChallengeImage()
            setupChallengeDate()
        }
    }
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func setupChallengeImage() {
        if let image = imageCache.object(forKey: NSString(string: (challenge?.imageUrl)!)) {
            self.themeImage.image = image
        } else {
            DispatchQueue.main.async(execute: {
                UIImage.fetch(with: self.challenge!.imageUrl) { (image) in
                    self.themeImage.image = image
                    self.imageCache.setObject(image, forKey: NSString(string: (self.challenge?.imageUrl)!))
                }
            })
        }
    }
    
    func setupChallengeDate() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: (self.challenge?.startDate)!)
        let month = components.month
        let day = components.day
        self.dateLabel.text = "\(month ?? 0)/\(day ?? 0)"
    }
}

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
    
    func setupChallengeImage() {
        let url = URL(string: (self.challenge?.imageUrl)!)
        self.themeImage.sd_setImage(with: url, completed: nil)
    }
    
    func setupChallengeDate() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: (self.challenge?.startDate)!)
        let month = components.month
        let day = components.day
        self.dateLabel.text = "\(month ?? 0)/\(day ?? 0)"
    }
}

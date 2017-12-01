//
//  ChallengeCollectionViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeCollectionViewCell: UICollectionViewCell, ChallengesCellView {
    @IBOutlet weak var themeImage: UIImageView!
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var numPhotosLabel: UILabel!
    
    @IBOutlet weak var gradientLayer: UIView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var imageCache = NSCache<NSString, UIImage>()
    
    var presenter : ChallengesCellPresenter?
    
    var challenge : Challenge? {
        didSet {
            self.themeLabel.text = challenge?.theme
            setupChallengeImage()
        }
    }
    
    func setupChallengeImage() {
        if let image = imageCache.object(forKey: NSString(string: (challenge?.imageUrl)!)) {
            self.themeImage.image = image
        } else {
            UIImage.fetch(with: self.challenge!.imageUrl) { (image) in
                
                self.themeImage.image = image
                self.imageCache.setObject(image, forKey: NSString(string: (self.challenge?.imageUrl)!))
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = ChallengesCellPresenterImp(challengeCellView: self)
    }
    
}

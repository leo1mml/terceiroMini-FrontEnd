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
    
    let imageCache = NSCache<NSString, UIImage>()
    
    var presenter : ChallengesCellPresenter?
    
    var challenge : Challenge? {
        didSet {
            self.themeLabel.text = challenge?.theme
            setupChallengeImage()
        }
    }
    
    func setupChallengeImage() {
        if let image = challenge?.image {
            self.themeImage.image = image
        } else {
            ChallengeNet.fetchImage(completion: { (image) in
                self.challenge?.image = image
                self.themeImage.image = image
            }, with: (self.challenge?.imageUrl)!)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = ChallengesCellPresenterImp(challengeCellView: self)
    }
    
}

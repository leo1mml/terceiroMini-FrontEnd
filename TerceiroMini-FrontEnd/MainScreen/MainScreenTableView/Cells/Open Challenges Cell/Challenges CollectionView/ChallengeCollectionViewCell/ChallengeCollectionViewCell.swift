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
    var timerDate = Timer()
    
    var challenge : Challenge? {
        didSet {
            self.themeLabel.text = challenge?.theme
            self.numPhotosLabel.text = "\(challenge?.numPhotos ?? 9999) fotos"
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            setupChallengeImage()
        }
    }
    
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
    
    @objc func updateTimer() {
            let dateInterval = self.challenge?.endDate.timeIntervalSince(Date())
        self.timerLabel.text = "\(String(describing: dateInterval!.format()!))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = ChallengesCellPresenterImp(challengeCellView: self)
    }
    
}

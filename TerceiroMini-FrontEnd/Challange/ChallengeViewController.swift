//
//  ChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    
    let startingGradientColor = UIColor(red:0, green:0, blue:0, alpha:0.7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.addChallengeGradientLayer(frame: view.bounds, colors: [startingGradientColor,.clear,.white])
    }

    
}


extension UIImageView{
    func addChallengeGradientLayer(frame: CGRect, colors: [UIColor] ){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
}

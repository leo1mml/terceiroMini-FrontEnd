//
//  UIImageView+Extension.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 06/12/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

extension UIImageView{
    func addChallengeGradientLayer(frame: CGRect, colors: [UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
}

//
//  UIView+Extension.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setDarkGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.55)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.9999)
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}

//
//  UIView+Extension.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 23/11/2017.
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
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.9999)
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func setCustomGradient(colorOne: UIColor, colorTwo: UIColor, locationX: Float, locationY: Float, startPoint: CGPoint, endPoint: CGPoint){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [locationX as NSNumber, locationY as NSNumber]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
}


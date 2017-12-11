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
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func makeBorderAnimate(){
        
        let shapeLayer = CAShapeLayer()
        
        layer.addSublayer(shapeLayer)
        
        let path = UIBezierPath(ovalIn: bounds)
        shapeLayer.strokeStart = 0.10
        shapeLayer.strokeEnd = 0.90
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let a = CABasicAnimation(keyPath: "strokeEnd")
        a.fromValue = 0.10
        a.toValue = 0.90
        a.duration = 3
        shapeLayer.add(a, forKey: nil)
        
    }
    
    
    
}


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
        gradient.name = "gradient"
//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.duration = 0.5
//        gradient.add(animation, forKey: "opacity")
        self.layer.addSublayer(gradient)
    }
    
    func removeChallengeGradientLayer(){
        if self.layer.sublayers != nil {
            for layer in self.layer.sublayers! {
                if layer.name == "gradient" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func addChallengeGradientBottonMainCell(frame: CGRect, colors: [UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        gradient.locations = [0.0, 0.5]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        self.layer.addSublayer(gradient)
    }
    
    func addChallengeGradientTopMainCell(frame: CGRect, colors: [UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        gradient.locations = [0.0, 0.3]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.layer.addSublayer(gradient)
    }
}

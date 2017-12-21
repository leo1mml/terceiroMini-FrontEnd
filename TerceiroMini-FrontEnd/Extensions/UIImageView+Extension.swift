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

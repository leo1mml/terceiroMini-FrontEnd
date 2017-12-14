//
//  BackgroundImageView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 11/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

private let heightConstraint = "heightConstraint"

class BackgroundImageView: UIImageView {
    
    private var gradientTop: CAGradientLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        setup()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }
    
    func setup() {
    
        // Gradient #1
        
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint   = CGPoint(x: 1, y: 1)

        gradientTop = buildGradient(colors: [Colors.gradientBlack, .clear], locationX: 0, locationY: 0.35, startPoint: startPoint, endPoint: endPoint)

        layer.addSublayer(gradientTop)
    }
    
    func changeTopGradient(by newGradient: CAGradientLayer) {
        
        gradientTop.removeFromSuperlayer()
        
        gradientTop = newGradient
        layer.addSublayer(gradientTop)
    }
    
    func buildGradient(colors: [UIColor], locationX: Float, locationY: Float, startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map{$0.cgColor}
        gradientLayer.locations = [locationX as NSNumber, locationY as NSNumber]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        return gradientLayer
    }
    
}

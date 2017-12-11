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
    
    private var gradients: [String: CAGradientLayer]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        commonInit()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        commonInit()
    }
    
    func commonInit() {
    
        // Gradient #1
        
        var startPoint = CGPoint(x: 0, y: 0)
        var endPoint = CGPoint(x: 1, y: 1)
        
        let gradientTop = buildGradient(colors: [Colors.gradientBlack, .clear], locationX: 0, locationY: 0.35, startPoint: startPoint, endPoint: endPoint)
        
        // Gradient #2
        
        startPoint = CGPoint(x: 0.5, y: 1)
        endPoint = CGPoint(x: 0.5, y: 0)
        
        let gradientBottom = buildGradient(colors: [Colors.gradientBlack, .clear], locationX: 0, locationY: 0.6, startPoint: startPoint, endPoint: endPoint)
        
        gradients = ["top": gradientTop, "bottom": gradientBottom]
        
        layer.addSublayer(gradientTop)
        layer.addSublayer(gradientBottom)
    }
    
    func set(heightSize: CGFloat, animated: Bool = false) {
        
        let c = constraints.filter { return $0.identifier == heightConstraint }
        
        guard c.count == 1 else {
            return
        }
        
        let height = c.first!
        height.constant = heightSize
        gradients.forEach { $1.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: heightSize)) }
        
        guard animated else {
            layoutIfNeeded()
            layer.layoutSublayers()
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layer.layoutSublayers()
        }
        
    }
    
    func changeGradient(named key: String, by newGradient: CAGradientLayer) {
        
        guard let oldGradient = gradients[key] else {
            return
        }
        
        oldGradient.removeFromSuperlayer()
        
        gradients[key] = newGradient
        layer.addSublayer(newGradient)
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

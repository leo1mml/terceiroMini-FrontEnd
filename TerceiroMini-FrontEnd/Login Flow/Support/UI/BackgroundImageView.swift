//
//  BackgroundImageView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 11/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class BackgroundImageView: UIImageView {
    
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
        
        self.setCustomGradient(colors: [Colors.gradientBlack, .clear], locationX: 0, locationY: 0.35, startPoint: startPoint, endPoint: endPoint)
        
        // Gradient #2
        
        startPoint = CGPoint(x: 0.5, y: 1)
        endPoint = CGPoint(x: 0.5, y: 0)
        
        self.setCustomGradient(colors: [Colors.gradientBlack, .clear], locationX: 0, locationY: 0.6, startPoint: startPoint, endPoint: endPoint)
    }
    
    

}

//
//  GradientView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class GradientView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        apllyGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        apllyGradient()
    }
    
    func apllyGradient() {
        self.setDarkGradientBackground(colorOne: .clear, colorTwo: UIColor(red: 70/255, green: 79/255, blue: 85/255, alpha: 1.00))
    }
    
}

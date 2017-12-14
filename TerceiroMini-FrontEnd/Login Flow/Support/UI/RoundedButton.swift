//
//  RoundedButton.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 04/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = frame.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = frame.height / 2
    }

}

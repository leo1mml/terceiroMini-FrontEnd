//
//  BottomLineLabel.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 02/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class BottomLineTextField: UITextField, UITextFieldDelegate {

    var bottomLine: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        
        bottomLine = createBottomLine()
        layer.addSublayer(bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
        
        bottomLine = createBottomLine()
        layer.addSublayer(bottomLine)
    }
    
    func createBottomLine() -> CALayer {
        
        let size = CGSize(width: frame.width, height: 1)
        let point = CGPoint(x: bounds.minX, y: bounds.maxY)
        
        let layer = CALayer()
        layer.frame = CGRect(origin: point, size: size)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2.0
        
        return layer
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bottomLine.borderColor = UIColor.lightGray.cgColor
        bottomLine.borderWidth = 1.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomLine.borderColor = UIColor.black.cgColor
        bottomLine.borderWidth = 2.0
    }
}

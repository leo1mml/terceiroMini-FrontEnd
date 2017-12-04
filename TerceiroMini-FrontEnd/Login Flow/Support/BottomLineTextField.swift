//
//  BottomLineLabel.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 02/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class BottomLineTextField: UITextField, UITextFieldDelegate {

    static let firstResponderColor: UIColor = .black
    static let nonFirstResponderColor: UIColor = .lightGray
    
    static let firstResponderBorder: CGFloat = 2.0
    static let nonFisrtResponderBorder: CGFloat = 1.0
    
    var bottomLine: CALayer!
    
    @IBInspectable var bottomLineBorderWidth: CGFloat = 1.0 {
        
        didSet {
            bottomLine.borderWidth = bottomLineBorderWidth
        }
    }
    
    @IBInspectable var bottomLineColor: UIColor = .black {
        
        didSet {
            bottomLine.borderColor = bottomLineColor.cgColor
        }
    }
    
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
        let point = CGPoint(x: 0, y: frame.maxY - BottomLineTextField.firstResponderBorder)
        
        let layer = CALayer()
        layer.frame = CGRect(origin: point, size: size)
        layer.borderColor = BottomLineTextField.nonFirstResponderColor.cgColor
        layer.borderWidth = BottomLineTextField.nonFisrtResponderBorder
        
        return layer
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bottomLine.borderColor = BottomLineTextField.nonFirstResponderColor.cgColor
        bottomLine.borderWidth = BottomLineTextField.nonFisrtResponderBorder
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomLine.borderColor = BottomLineTextField.firstResponderColor.cgColor
        bottomLine.borderWidth = BottomLineTextField.firstResponderBorder
    }
}

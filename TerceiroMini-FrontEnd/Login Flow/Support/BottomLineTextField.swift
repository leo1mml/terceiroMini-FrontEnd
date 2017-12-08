//
//  BottomLineLabel.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 02/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

protocol EditingListener {
    
    func didBeginEditing(_ sender: BottomLineTextField)
    func didEndEditing(_ sender: BottomLineTextField)
}

class BottomLineTextField: UITextField, UITextFieldDelegate {

    static let firstResponderColor: UIColor = .black
    static let nonFirstResponderColor: UIColor = .lightGray
    
    static let firstResponderBorder: CGFloat = 2.0
    static let nonFisrtResponderBorder: CGFloat = 1.0
    
    var listenter: EditingListener?
    
    private var bottomLine: CALayer!
    private var placeholderLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        
        placeholderLbl = createSpecialPlaceholder()
        bottomLine = createBottomLine()
        addSubview(placeholderLbl)
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
        
        placeholderLbl = createSpecialPlaceholder()
        bottomLine = createBottomLine()
        addSubview(placeholderLbl)
        layer.addSublayer(bottomLine)
        layer.masksToBounds = false
    }
    
    func createSpecialPlaceholder() -> UILabel {
        
        let placeholder = UILabel(frame: CGRect(origin: CGPoint(), size: frame.size))
        
        placeholder.text = self.placeholder
        self.placeholder = nil
        placeholder.font = UIFont(name: "Montserrat-Bold", size: 13)
        
        return placeholder
    }
    
    func createBottomLine() -> CALayer {
        
        let size = CGSize(width: frame.size.width, height: 1)
        let point = CGPoint(x: 0, y: frame.size.height - BottomLineTextField.firstResponderBorder)
        
        let layer = CALayer()
        layer.frame = CGRect(origin: point, size: size)
        layer.borderColor = BottomLineTextField.nonFirstResponderColor.cgColor
        layer.borderWidth = BottomLineTextField.nonFisrtResponderBorder
        
        return layer
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bottomLine.borderColor = BottomLineTextField.nonFirstResponderColor.cgColor
        bottomLine.borderWidth = BottomLineTextField.nonFisrtResponderBorder
        
        movePlaceholder(y: 0)
        listenter?.didEndEditing(self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomLine.borderColor = BottomLineTextField.firstResponderColor.cgColor
        bottomLine.borderWidth = BottomLineTextField.firstResponderBorder
        
        movePlaceholder(y: -25)
        listenter?.didBeginEditing(self)
    }
    
    func movePlaceholder(y: CGFloat) {
        
        if text!.isEmpty {
            
            UIView.animate(withDuration: 0.3) {
                self.placeholderLbl.frame.origin = CGPoint(x: 0, y: y)
            }
        }
    }
}

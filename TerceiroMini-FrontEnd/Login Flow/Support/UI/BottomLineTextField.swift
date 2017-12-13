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
    func didEndEditing  (_ sender: BottomLineTextField)
}

private let firstResponderLineColor = Colors.gradientBlack
private let defaultLineColor        = Colors.lightGray
private let defaultPlaceholderColor = Colors.darkGray

class BottomLineTextField: UITextField, UITextFieldDelegate {
    
    static let firstResponderBorder: CGFloat = 2.0
    static let nonFisrtResponderBorder: CGFloat = 1.0
    
    var listenter: EditingListener?
    
    private var bottomLine: CALayer!
    private var placeholderLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        delegate = self
        
        placeholderLbl = createSpecialPlaceholder()
        addSubview(placeholderLbl)
        
        bottomLine = createBottomLine()
        layer.addSublayer(bottomLine)
        layer.masksToBounds = false
    }
    
    private func createSpecialPlaceholder() -> UILabel {
        
        let placeholder = UILabel(frame: CGRect(origin: CGPoint(), size: frame.size))
        
        placeholder.text = self.placeholder
        self.placeholder = nil
        placeholder.font = UIFont(name: "Montserrat-Light", size: 13)
        placeholder.textColor = defaultPlaceholderColor
        
        return placeholder
    }
    
    private func createBottomLine() -> CALayer {
        
        let size = CGSize(width: frame.size.width, height: 1)
        let point = CGPoint(x: 0, y: frame.size.height - 10.0)
        
        let layer = CALayer()
        layer.frame = CGRect(origin: point, size: size)
        layer.backgroundColor = defaultLineColor.cgColor
        
        return layer
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bottomLine.borderColor = defaultLineColor.cgColor
        bottomLine.borderWidth = BottomLineTextField.nonFisrtResponderBorder
        
        movePlaceholder(y: 0)
        listenter?.didEndEditing(self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomLine.borderColor = firstResponderLineColor.cgColor
        bottomLine.borderWidth = BottomLineTextField.firstResponderBorder
        
        movePlaceholder(y: -25)
        listenter?.didBeginEditing(self)
    }
    
    private func movePlaceholder(y: CGFloat) {
        
        if text!.isEmpty {
            
            UIView.animate(withDuration: 0.3) {
                self.placeholderLbl.frame.origin = CGPoint(x: 0, y: y)
            }
        }
    }
}

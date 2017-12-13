//
//  ConfigHeader.swift
//  TerceiroMini-FrontEnd
//
//  Created bConfigHeadery Leonel Menezes on 12/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ConfigHeader: UIView {

    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ConfigurationHeader", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}

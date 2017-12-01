//
//  ChallengeClosedViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeClosedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBDesignable
    class CustomButtonClick: UIButton {
        override func layoutSubviews() {
            super.layoutSubviews()
            contentHorizontalAlignment = .left
            let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
            let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
        }
    }

}

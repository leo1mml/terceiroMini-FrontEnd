//
//  ChallengeClosedViewController+scrollView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 19/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

extension ChallengeClosedViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}

//
//  ChallengeClosedView+UIGestureRecognizerDelegate.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 18/02/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import Foundation
import UIKit

extension ChallengeClosedViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer &&
            otherGestureRecognizer is UISwipeGestureRecognizer {
            return true
        }
        return false
    }
    
}

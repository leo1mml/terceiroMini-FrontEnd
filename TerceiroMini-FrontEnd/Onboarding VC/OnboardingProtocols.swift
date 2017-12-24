//
//  OnboardingProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 23/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

protocol OnboardingView {
    
    weak var image: UIImageView! { get set }
    
    weak var titleText: UILabel! { get set }
    
    weak var descText: UITextView! { get set }

}

protocol OnboardingPresenter {
    func animateLeft()
    func animateRigth()
}

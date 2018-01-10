//
//  OnboardingPresenter.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 23/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPresenterImpl: OnboardingPresenter {
    
    var view: OnboardingView?
    
    init(onboardingView: OnboardingView) {
        self.view = onboardingView
    }
    
}

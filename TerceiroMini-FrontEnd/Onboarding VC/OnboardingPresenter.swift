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
    
    func animateLeft() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            var imageFrame = self.view?.image.frame
            let imageFrameLocal = imageFrame
            imageFrame?.origin.x -= (imageFrameLocal?.size.width)!/2
            self.view?.image.frame = imageFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveLinear, animations: {
            var titleFrame = self.view?.titleText.frame
            let titleFrameLocal = titleFrame
            titleFrame?.origin.x -= (titleFrameLocal?.size.width)!/2
            self.view?.titleText.frame = titleFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveLinear, animations: {
            var descFrame = self.view?.descText.frame
            let descFrameLocal = descFrame
            descFrame?.origin.x -= (descFrameLocal?.size.width)!/2
            self.view?.descText.frame = descFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
            var imageFrame = self.view?.image.frame
            let imageFrameLocal = imageFrame
            imageFrame?.origin.x += (imageFrameLocal?.size.width)!/2
            self.view?.image.frame = imageFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseOut, animations: {
            var titleFrame = self.view?.titleText.frame
            let titleFrameLocal = titleFrame
            titleFrame?.origin.x += (titleFrameLocal?.size.width)!/2
            self.view?.titleText.frame = titleFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.8, delay: 0.3, options: .curveEaseOut, animations: {
            var descFrame = self.view?.descText.frame
            let descFrameLocal = descFrame
            descFrame?.origin.x += (descFrameLocal?.size.width)!/2
            self.view?.descText.frame = descFrame!
        }, completion: { finished in })
        
    }
    
    func animateRigth() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            var imageFrame = self.view?.image.frame
            let imageFrameLocal = imageFrame
            imageFrame?.origin.x += (imageFrameLocal?.size.width)!/2
            self.view?.image.frame = imageFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
            var titleFrame = self.view?.titleText.frame
            let titleFrameLocal = titleFrame
            titleFrame?.origin.x += (titleFrameLocal?.size.width)!/2
            self.view?.titleText.frame = titleFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveEaseOut, animations: {
            var descFrame = self.view?.descText.frame
            let descFrameLocal = descFrame
            descFrame?.origin.x += (descFrameLocal?.size.width)!/2
            self.view?.descText.frame = descFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
            var imageFrame = self.view?.image.frame
            let imageFrameLocal = imageFrame
            imageFrame?.origin.x -= (imageFrameLocal?.size.width)!/2
            self.view?.image.frame = imageFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveLinear, animations: {
            var titleFrame = self.view?.titleText.frame
            let titleFrameLocal = titleFrame
            titleFrame?.origin.x -= (titleFrameLocal?.size.width)!/2
            self.view?.titleText.frame = titleFrame!
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.8, delay: 0.3, options: .curveLinear, animations: {
            var descFrame = self.view?.descText.frame
            let descFrameLocal = descFrame
            descFrame?.origin.x -= (descFrameLocal?.size.width)!/2
            self.view?.descText.frame = descFrame!
        }, completion: { finished in })
        
    }
    
}

//
//  OnboardingViewController+scrollView.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 04/01/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import Foundation
import UIKit

extension OnboardingViewController: UIScrollViewDelegate {
    
    func initializeScroll(index: Int) {
        
        for i in 0..<self.titles.count {
            
            let xPosition = self.view.frame.width * CGFloat(i)
            
            let cgRect = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            
            let textView: OnboardingCustomView = OnboardingCustomView(frame: cgRect)
            
            textView.titleLabel.text = self.titles[i]
            textView.descriptionText.text = self.descriptions[i]
            
            self.scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(i + 1)
            self.scrollView.addSubview(textView)
            self.scrollView.contentOffset.x = self.scrollView.frame.size.width * CGFloat(index)

        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let imageIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
    
}

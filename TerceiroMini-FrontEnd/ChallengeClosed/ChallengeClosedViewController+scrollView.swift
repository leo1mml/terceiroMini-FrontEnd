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
    
    func initializeScroll(index: Int) {
        
        for i in 0..<images.count {

            let imageView = UIImageView()
            
            UIImage.fetch(with: images[i], completion: { (image) in
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                imageView.addChallengeGradientLayer(frame: self.view.bounds, colors: [self.colorGradient, .clear, .clear, .clear])
                let xPosition = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
                
                self.scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(i + 1)
                self.scrollView.addSubview(imageView)
                self.scrollView.contentOffset.x = self.scrollView.frame.size.width * CGFloat(index)
            })
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        imageIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        presenter?.checkIfChosenClick(currentPhoto: (self.data?.0[imageIndex])!)

        updatePhotoCount()
    }
    
}

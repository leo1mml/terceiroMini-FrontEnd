//
//  Onboarding4ViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class Onboarding4ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var descText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animateLeft()
        self.animateRigth()
    }
    
    func animateLeft() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            var imageFrame = self.image.frame
            imageFrame.origin.x -= imageFrame.size.width/2
            
            var titleFrame = self.titleText.frame
            titleFrame.origin.x -= titleFrame.size.width/2
            
            var descFrame = self.descText.frame
            descFrame.origin.x -= descFrame.size.width/2
            
            self.image.frame = imageFrame
            self.titleText.frame = titleFrame
            self.descText.frame = descFrame
        }, completion: { finished in
            print("Basket doors opened!")
        })
    }
    
    func animateRigth() {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
            var imageFrame = self.image.frame
            imageFrame.origin.x += imageFrame.size.width/2
            
            var titleFrame = self.titleText.frame
            titleFrame.origin.x += titleFrame.size.width/2
            
            var descFrame = self.descText.frame
            descFrame.origin.x += descFrame.size.width/2
            
            self.image.frame = imageFrame
            self.titleText.frame = titleFrame
            self.descText.frame = descFrame
        }, completion: { finished in
            print("Basket doors opened!")
        })
    }
    
    @IBAction func vamosLaButton(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "boarded")
        performSegue(withIdentifier: "onboardingSegue", sender: self)
        
    }

}

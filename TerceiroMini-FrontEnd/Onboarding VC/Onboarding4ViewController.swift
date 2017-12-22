//
//  Onboarding4ViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class Onboarding4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func vamosLaButton(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "boarded")
        performSegue(withIdentifier: "onboardingSegue", sender: self)
        
    }

}

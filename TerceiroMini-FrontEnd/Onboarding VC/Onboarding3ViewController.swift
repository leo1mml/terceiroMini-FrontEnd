//
//  Onboarding3ViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 23/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class Onboarding3ViewController: UIViewController, OnboardingView  {

    var isRigth: Bool? = true
    
    var presenter: OnboardingPresenter?
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var descText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OnboardingPresenterImpl(onboardingView: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isRigth! {
            presenter?.animateLeft()
        } else {
            presenter?.animateRigth()
        }
    }

}

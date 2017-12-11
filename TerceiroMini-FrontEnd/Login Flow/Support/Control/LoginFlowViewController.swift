//
//  StatusBarHiddenViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 04/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class LoginFlowViewController: UIViewController {

    var previousPage: LoginFlowViewController?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController = segue.destination as? LoginFlowViewController else {
            return
        }
        
        nextViewController.previousPage = self
    }
    
    func dismissInChain(animated: Bool, completion: @escaping () -> Void) {
        
        guard let previousPage = self.previousPage else {
            completion()
            return
        }
        
        dismiss(animated: animated) {
            
            previousPage.dismissInChain(animated: animated, completion: completion)
        }
    }
}

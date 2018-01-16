//
//  StatusBarHiddenViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 04/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

protocol LoginCallerPortocol {
    
    var isMainScreen: Bool { get set }
    func loginFinishedSuccessfully()
}

extension LoginCallerPortocol {
    
    var isMainScreen: Bool { return false }
    func loginFinishedSuccessfully() {}
}

class LoginFlowViewController: UIViewController {

    var previousPage: LoginFlowViewController?
    var caller: LoginCallerPortocol?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController = segue.destination as? LoginFlowViewController else {
            return
        }
        
        nextViewController.previousPage = self
        nextViewController.caller = self.caller
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

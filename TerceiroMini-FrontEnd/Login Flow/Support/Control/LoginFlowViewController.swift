//
//  StatusBarHiddenViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 04/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

protocol LoginCallerPortocol {
    
    var isMainScreen: Bool { get }
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
    }
    
    func dismissInChain(animated: Bool, completion: @escaping () -> Void) {
        
        let previousPage = self.previousPage
        
        dismiss(animated: animated) {
            
            guard let pp = previousPage else {
                completion()
                return
            }
            
            pp.dismissInChain(animated: animated, completion: completion)
        }
    }
}

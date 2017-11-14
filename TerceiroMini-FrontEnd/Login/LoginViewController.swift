//
//  ViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 06/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginView {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var presenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        
    }

    @IBAction func login(_ sender: UIButton) {
        
        presenter?.validateCredentials(username: usernameField.text!, password: passwordField.text!)
    }
    
    func showMissingFieldsError() {
        
    }
    
    func showInvalidCredentialsError() {
        
    }
    
    func changeScreen() {
        
        performSegue(withIdentifier: "", sender: self)
    }
    
}


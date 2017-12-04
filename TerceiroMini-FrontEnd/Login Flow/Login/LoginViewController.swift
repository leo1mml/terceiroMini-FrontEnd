//
//  ViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 06/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

private let segueToRegister = "loginToRegister"

class LoginViewController: UIViewController, LoginView {

    // MARK: - Outlets
    
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Attributes
    
    var presenter: LoginPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresenterImpl(loginViewImpl: self)
        
        let outTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(outTap)
    }
    
    // MARK: - Actions

    @IBAction func login(_ sender: UIButton) {
        
        presenter?.validateCredentials(username: usernameField.text!, password: passwordField.text!)
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        presenter?.forgotPassword()
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        presenter?.createAccount()
    }
    
    // MARK: - LoginView implementation
    
    func showMissingFieldsError() {
        
    }
    
    func showInvalidCredentialsError() {
        
    }
    
    func goToRegister() {
        performSegue(withIdentifier: segueToRegister, sender: self)
    }
    
    // MARK: - Auxiliar
    
    @objc func dismissKeyboard() {
        usernameField.endEditing(false)
        passwordField.endEditing(false)
    }
    
}

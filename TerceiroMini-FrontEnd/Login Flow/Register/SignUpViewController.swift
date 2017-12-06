//
//  CadastroViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, SignUpView, UITextFieldDelegate {

    var presenter: SignUpPresenter?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    @IBOutlet weak var repeatPasswordInvalid: UILabel!
    @IBOutlet weak var emailInvalid: UILabel!
    @IBOutlet weak var usernameInvalid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repeatPasswordInvalid.isHidden = true
        emailInvalid.isHidden = true
        usernameInvalid.isHidden = true
        
        presenter = SignUpPresenterImpl(signUpView: self)
        
        self.nameField.delegate = self
        self.emailField.delegate = self
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.repeatPasswordField.delegate = self
        
    }
    
    // Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        repeatPasswordInvalid.isHidden = true
        emailInvalid.isHidden = true
        usernameInvalid.isHidden = true
        self.view.endEditing(true)
    }
    
    // Press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        repeatPasswordField.resignFirstResponder()
        return (true)
    }

    @IBAction func SignUpAction(_ sender: Any) {
        
        presenter?.validateData(name: nameField.text!, email: emailField.text!, username: usernameField.text!, password: passwordField.text!, repeatPassword: repeatPasswordField.text!)
        
    }
    
    func showInvalidRepeatPassword() {
        
        repeatPasswordInvalid.isHidden = false
        
    }
    
    func showInvalidUsername() {
        
        usernameInvalid.isHidden = false
        
    }
    
    func showInvalidEmail() {
        
        emailInvalid.isHidden = false
        
    }
    
    func changeScreen() {
        
    }
}

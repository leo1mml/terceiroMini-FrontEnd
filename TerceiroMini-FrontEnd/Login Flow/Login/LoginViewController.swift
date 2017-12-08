//
//  ViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 06/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

private let segueToRegister = "loginToRegister"

class LoginViewController: HiddenStatusBarViewController, LoginView, EditingListener {

    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgrounImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var usernameField: BottomLineTextField!
    @IBOutlet weak var passwordField: BottomLineTextField!
    
    @IBOutlet weak var agreementLabel: UILabel!
    
    // MARK: - Attributes
    
    var presenter: LoginPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresenterImpl(loginViewImpl: self)
        
        let outTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(outTap)
        
        usernameField.listenter = self
        passwordField.listenter = self
        
        setupTexts()
    }
    
    // MARK: - Actions

    @IBAction func login(_ sender: UIButton) {
        
        presenter?.validateCredentials(email: usernameField.text!, password: passwordField.text!)
    }
    
    @IBAction func goBackAction(_ sender: UIButton) {
        presenter?.goBack()
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
    
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func goToApp() {
        
    }
    
    // MARK: - EditingListener implementation
    
    func didBeginEditing(_ sender: BottomLineTextField) {
        setBackgroundImageSize(191)
    }
    
    func didEndEditing(_ sender: BottomLineTextField) {
        setBackgroundImageSize(291)
    }
    
    // MARK: - Auxiliar
    
    @objc func dismissKeyboard() {
        usernameField.endEditing(false)
        passwordField.endEditing(false)
    }
    
    private func setupTexts() {
        welcomeMessageLabel.text = "Seja bem-vindo!"
        instructionLabel.text = "para concluir a ação,\nfaça seu login"
        agreementLabel.text = "Ao entrar no aplicativo, você concorda com os nossos termos de serviço e políticas de privacidade."
    }
    
    private func setBackgroundImageSize(_ constant: CGFloat) {
        
        backgrounImageHeight.constant = constant
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.layoutIfNeeded()
        }
    }
}

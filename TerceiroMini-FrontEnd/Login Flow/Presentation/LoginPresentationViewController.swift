//
//  LoginPresentationViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 27/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

private let segueToLogin = "presentationToLogin"
private let segueToRegister = "presentationToRegister"

class LoginPresentationViewController: UIViewController, LoginPresentationView {

    // MARK: - Attributes
    
    var presenter: LoginPresentationPresenter?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var instructionTextLabel: UILabel!
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    @IBOutlet weak var agreementWarningLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresentationPresenterImpl(loginPresentationViewImpl: self)
        
        emailLoginButton.addTarget(self, action: #selector(emailLoginAction), for: .touchUpInside)
        facebookLoginButton.addTarget(self, action: #selector(facebookLoginAction), for: .touchUpInside)
        
        setupButtonRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTexts()
    }
    
    // MARK: - View settings
    
    private func setupTexts() {
        welcomeTextLabel.text = "Seja bem-vindo!"
        instructionTextLabel.text = "para concluir a ação,\nfaça seu login"
        agreementWarningLabel.text = "Ao entrar no aplicativo, você concorda com os nossos termos de serviço e políticas de privacidade."
    }
    
    private func setupButtonRadius() {
        
        let radius = emailLoginButton.frame.height / 2
        
        emailLoginButton.layer.cornerRadius = radius
        facebookLoginButton.layer.cornerRadius = radius
    }
    
    // MARK: - Actions
    
    @IBAction func exitAction(_ sender: UIButton) {
        presenter?.exitButtonClicked()
    }
    
    @objc func emailLoginAction() {
        presenter?.emailLoginButtonClicked()
    }
    
    @objc func facebookLoginAction() {
        presenter?.facebookLoginButtonClicked()
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        presenter?.createAccountButtonClicked()
    }
    
    // MARK: - View implementation
    
    func exitLoginPresentation() {
        dismiss(animated: true, completion: nil)
    }
    
    func goToLogin() {
        performSegue(withIdentifier: segueToLogin, sender: self)
    }
    
    func goToRegister() {
        performSegue(withIdentifier: segueToRegister, sender: self)
    }
}

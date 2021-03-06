//
//  ViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 06/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import NotificationBannerSwift

private let segueToRegister = "loginToRegister"

class LoginViewController: UIViewController, LoginView, EditingListener {

    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: BackgroundImageView!
    @IBOutlet weak var backgroundImageHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageBottomGradientView: UIView!
    
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var usernameField: BottomLineTextField!
    @IBOutlet weak var passwordField: BottomLineTextField!
    
    @IBOutlet weak var agreementLabel: UILabel!
    
    // MARK: - Attributes
    
    var presenter: LoginPresenter?
    var loginProtocol : LoginCallerPortocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresenterImpl(loginViewImpl: self)
        
        let outTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(outTap)
        
        usernameField.listenter = self
        passwordField.listenter = self
        
        setupBackgroundImageViewBottomGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTexts()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
        let banner = NotificationBanner(title: "Email ou senha incorretos", subtitle: "", style: .danger)
        banner.show()
    }
    
    func goToRegister() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        vc.loginProtocol = self.loginProtocol
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToApp() {
        self.loginProtocol?.loginFinishedSuccessfully()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    // MARK: - EditingListener implementation
    
    func didBeginEditing(_ sender: BottomLineTextField) {
        setBackgroundImageHeight(191)
    }
    
    func didEndEditing(_ sender: BottomLineTextField) {
        setBackgroundImageHeight(291)
    }
    
    // MARK: - Auxiliar
    
    @objc func dismissKeyboard() {
        usernameField.endEditing(false)
        passwordField.endEditing(false)
    }
    
    private func setupTexts() {
        welcomeMessageLabel.text = "Seja bem-vindo!"
        instructionLabel.text = "para concluir a ação,\nfaça seu login"
        agreementLabel.text = "Ao entrar no aplicativo, você concorda com os nossos\ntermos de serviço e políticas de privacidade."
    }
    
    private func setBackgroundImageHeight(_ height: CGFloat) {
        
        backgroundImageHeight.constant = height
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func setupBackgroundImageViewBottomGradient() {
        
        backgroundImageBottomGradientView.setUpsideDownDarkGradientBackground(colorOne: Colors.gradientBlack, colorTwo: .clear)
    }
}

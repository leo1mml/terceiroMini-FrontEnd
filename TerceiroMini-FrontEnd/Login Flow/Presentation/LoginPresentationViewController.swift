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

class LoginPresentationViewController: LoginFlowViewController, LoginPresentationView {

    // MARK: - Attributes
    
    var presenter: LoginPresentationPresenter?
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: BackgroundImageView!
    @IBOutlet weak var backgroundImageHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageBottomGradientView: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var instructionTextLabel: UILabel!
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    @IBOutlet weak var agreementWarningLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresentationPresenterImpl(loginPresentationViewImpl: self)
        
        exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
        emailLoginButton.addTarget(self, action: #selector(emailLoginAction), for: .touchUpInside)
        facebookLoginButton.addTarget(self, action: #selector(facebookLoginAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadHeader()
        setupTexts()
        setupBackgroundImageViewBottomGradient()
    }
    
    // MARK: - View settings
    
    private func setupTexts() {
        welcomeTextLabel.text = "Seja bem-vindo!"
        instructionTextLabel.text = "para concluir a ação,\nfaça seu login"
        agreementWarningLabel.text = "Ao entrar no aplicativo, você concorda com os nossos\ntermos de serviço e políticas de privacidade."
    }
    
    private func loadHeader() {
        
        guard let caller = self.caller else {
            return
        }
        
        if caller.isMainScreen {
            
            exitButton.isHidden = true
            logoImageView.isHidden = true
            
            let newGradient = backgroundImageView.buildGradient(colors: [Colors.darkWhite, .clear], locationX: 0, locationY: 0.35, startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
            
            backgroundImageView.image = #imageLiteral(resourceName: "special-presentation-background")
            backgroundImageView.changeTopGradient(by: newGradient)
            backgroundImageHeight.constant = 325
        }
    }
    
    // MARK: - Actions
    
    @objc func exitAction() {
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
    
    private func setupBackgroundImageViewBottomGradient() {
        
        backgroundImageBottomGradientView.setUpsideDownDarkGradientBackground(colorOne: Colors.gradientBlack, colorTwo: .clear)
    }
}

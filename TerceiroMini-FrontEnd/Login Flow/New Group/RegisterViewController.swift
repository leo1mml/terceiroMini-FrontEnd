//
//  RegisterViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 05/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class RegisterViewController: LoginFlowViewController, RegisterView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundImageBottomGradientView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var nameField: BottomLineTextField!
    @IBOutlet weak var emailField: BottomLineTextField!
    @IBOutlet weak var passwordField: BottomLineTextField!
    @IBOutlet weak var confirmField: BottomLineTextField!
    
    @IBOutlet weak var agreementLabel: UILabel!
    
    var presenter: RegisterPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RegisterPresenterImpl(registerView: self)
        
        let outTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(outTap)
        
        setupBackgroundImageViewBottomGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTexts()
    }

    @IBAction func goBackAction(_ sender: UIButton) {
        presenter?.goBack()
    }
    
    @IBAction func register(_ sender: UIButton) {
        presenter?.addUser(name: nameField.text!, email: emailField.text!, password: passwordField.text!, confirm: confirmField.text!)
    }
    
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func goToApp() {
        
        dismissInChain(animated: false) {
            
            self.caller?.loginFinishedSuccessfully()
        }
    }
    
    func showUpdateError(message: String) {
        switch message {
        case "{VALUE} is not a valid email":
            print("email invalido")
            break
        case "Path `{PATH}` (`{VALUE}`) is shorter than the minimum allowed length (6).":
            print("a senha deve ser maior que 6 digitos")
            break
        case "Email already in use":
            print(message)
            break
        default:
            print(message)
            print("sucesso")
        }
    }
    
    func showNonMatchingPasswordError() {
        
    }
    
    @objc func dismissKeyboard() {
        
        nameField.endEditing(false)
        emailField.endEditing(false)
        passwordField.endEditing(false)
        confirmField.endEditing(false)
    }
    
    private func setupTexts() {
        
        titleLabel.text = "Cadastro"
        instructionLabel.text = "preencha com seus dados\npara realizar o cadastro"
        agreementLabel.text = "Ao entrar no aplicativo, você concorda com nossos\ntemos de serviço e políticas de privacidade."
    }
    
    private func setupBackgroundImageViewBottomGradient() {
        
        backgroundImageBottomGradientView.setUpsideDownDarkGradientBackground(colorOne: Colors.gradientBlack, colorTwo: .clear)
    }
}

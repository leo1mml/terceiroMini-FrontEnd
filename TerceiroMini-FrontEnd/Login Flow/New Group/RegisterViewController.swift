//
//  RegisterViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 05/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class RegisterViewController: UIViewController, RegisterView {

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
    var loginProtocol : LoginCallerPortocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RegisterPresenterImpl(registerView: self)
        
        let outTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(outTap)
        
        setupBackgroundImageViewBottomGradient()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
       
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 160
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 160
        }
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToApp() {
        
        self.loginProtocol?.loginFinishedSuccessfully()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showUpdateError(message: String) {
        switch message {
        case "{VALUE} is not a valid email":
            let banner = NotificationBanner(title: "Email Inválido", subtitle: "Digite um email valido", style: .danger)
            banner.show()
            break
        case "Path `{PATH}` (`{VALUE}`) is shorter than the minimum allowed length (6).":
            let banner = NotificationBanner(title: "Senha Inválida", subtitle: "Digite uma senha de 6 caracteres no mínimo", style: .danger)
            banner.show()
            print("a senha deve ser maior que 6 digitos")
            break
        case "Email already in use":
            let banner = NotificationBanner(title: "Email em uso", subtitle: "Este email ja está sendo usado", style: .danger)
            banner.show()
            print(message)
            break
        case "Path `{PATH}` is required.":
            let banner = NotificationBanner(title: "Digite nos campos obrigatórios", subtitle: "", style: .danger)
            banner.show()
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

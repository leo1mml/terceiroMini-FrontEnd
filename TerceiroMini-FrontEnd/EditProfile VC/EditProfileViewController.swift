//
//  EditProfileViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 20/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, EditProfileView {

    @IBOutlet weak var nameTextField: BottomLineTextField!
    @IBOutlet weak var userNameTextField: BottomLineTextField!
    @IBOutlet weak var emailTextField: BottomLineTextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBorderView: UIView!
    
    var presenter : EditProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfigurationProfileImage()
        self.presenter = EditProfilePresenterImp(self)
        presenter?.recoverLogedUser()
        
        let outTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(outTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 130
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 130
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.profileImageBorderView.makeCircleBorderAnimate()
    }
    
    @objc func dismissKeyboard() {
        self.nameTextField.endEditing(false)
        self.emailTextField.endEditing(false)
        self.userNameTextField.endEditing(false)
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initialConfigurationProfileImage(){
        self.profileImage.layer.cornerRadius = self.profileImage.layer.bounds.width/2
        self.profileImage.image = UIImage(named: "profile-default")
    }
    
    func setProfileImage(url: String) {
        let url = URL(string: url)
        self.profileImage.sd_setImage(with: url, completed: nil)
    }
    
    func setUserDataHolders(nome: String, username: String?, email: String, birthDate: String?, sex: String?) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

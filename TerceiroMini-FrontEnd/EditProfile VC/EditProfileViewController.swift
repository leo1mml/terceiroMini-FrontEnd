//
//  EditProfileViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 20/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class EditProfileViewController: UIViewController, EditProfileView {
    
    

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var nameTextField: BottomLineTextField!
    @IBOutlet weak var userNameTextField: BottomLineTextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBorderView: UIView!
    let sexInputs = ["Masculino", "Feminino", "Não especificado"]
    let birthDatePicker = UIDatePicker()
    
    @IBOutlet weak var sexTextField: BottomLineTextField!
    @IBOutlet weak var birthDateTextField: BottomLineTextField!
    var presenter : EditProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfigurationProfileImage()
        self.presenter = EditProfilePresenterImp(self)
        presenter?.recoverLogedUser()
        createSexPicker()
        createToolBar()
        configureBithDatePicker()
        
        let outTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(outTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 120
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 120
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
        self.userNameTextField.endEditing(false)
        self.birthDateTextField.endEditing(false)
        self.sexTextField.endEditing(false)
    }
    
    @objc func dismissBirthPicker()  {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: birthDatePicker.date)
        self.birthDateTextField.placeholderLbl.text = "\(dateString)"
        self.birthDateTextField.endEditing(false)
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
    
    func createSexPicker() {
        let sexPicker = UIPickerView()
        sexPicker.delegate = self
        self.sexTextField.inputView = sexPicker
    }
    
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButon = UIBarButtonItem(title: "Escolher", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([doneButon], animated: false)
        toolbar.isUserInteractionEnabled = true
        sexTextField.inputAccessoryView = toolbar
    }
    
    func configureBithDatePicker() {
        birthDatePicker.datePickerMode = .date
        birthDatePicker.locale = Locale(identifier: "pt-BR")
        self.birthDateTextField.inputView = birthDatePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButon = UIBarButtonItem(title: "Escolher", style: .done, target: self, action: #selector(dismissBirthPicker))
        toolbar.setItems([doneButon], animated: false)
        toolbar.isUserInteractionEnabled = true
        birthDateTextField.inputAccessoryView = toolbar
    }
    
    func setUserDataHolders(name: String?, username: String?, birthDate: String?, sex: String?) {
        if(name !=  nil){
            self.nameTextField.placeholderLbl.text = name
        }
        if(sex !=  nil){
            self.sexTextField.placeholderLbl.text = sex
        }
        if(birthDate !=  nil){
            self.birthDateTextField.placeholderLbl.text = name
        }
        if(username != "empty"){
            self.userNameTextField.placeholderLbl.text = username
        }
    }
    
    func sendErrorMessage(message: String) {
        let msg : String
        switch message {
        case "User Name already in use":
            msg = "Nome de usuário não disponível"
        default:
            msg = message
        }
        
        let banner = NotificationBanner(title: msg, subtitle: "", style: .danger)
        banner.show()
    }
    
    func sendUknownErrorBanner() {
        let banner = NotificationBanner(title: "Erro Interno", subtitle: "", style: .danger)
        banner.show()
    }
    
    func sendSuccessBanner() {
        let banner = NotificationBanner(title: "Dados alterados!", subtitle: "", style: .success)
        banner.show()
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        var sex : Int?
        if(sexTextField.text == "Masculino"){
            sex = 1
        }else if(sexTextField.text == "Feminino"){
            sex = 2
        }else if(sexTextField.text == "Não especificado"){
            sex = 9
        }else {
            sex = 0
        }
        var birthDate : String?
        if(birthDateTextField.placeholderLbl.text != "Data de Nascimento"){
            birthDate = DateHelper.shared.getString(fromDate: self.birthDatePicker.date)
        }
        
        var name : String?
        if(nameTextField.text != ""){
            name = nameTextField.text
        }
        var userName : String?
        if(userNameTextField.text != ""){
            userName = userNameTextField.text
        }
        
        presenter?.sendChangesToServer(name: name, username: userName, sex: sex, birthDate: birthDate)
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

extension EditProfileViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.sexInputs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.sexTextField.text = self.sexInputs[row]
    }
    
    
}

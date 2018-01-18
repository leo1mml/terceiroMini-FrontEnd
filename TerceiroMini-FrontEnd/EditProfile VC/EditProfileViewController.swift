//
//  EditProfileViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 20/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import Fusuma

class EditProfileViewController: UIViewController, EditProfileView, FusumaDelegate{
    
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var nameTextField: BottomLineTextField!
    @IBOutlet weak var userNameTextField: BottomLineTextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBorderView: UIView!
    let sexInputs = ["Masculino", "Feminino", "Não especificado"]
    let birthDatePicker = UIDatePicker()
    let sexPicker = UIPickerView()
    
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
        self.profileImageBorderView.makeBorderAnimate()
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
        if(url != ""){
            let url = URL(string: url)
            self.profileImage.sd_setImage(with: url, completed: nil)
        }else{
            self.profileImage.image = UIImage(named: "profile-default")
        }
        
    }
    
    @IBAction func changeProfilePic(_ sender: Any) {
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1 // Height-to-width ratio. The default value is 1, which means a squared-size photo.
        fusuma.allowMultipleSelection = false // You can select multiple photos from the camera roll. The default value is false.
        fusumaCropImage = true
        fusumaCameraTitle = "Câmera"
        fusumaCameraRollTitle = "Biblioteca"
        fusumaBackgroundColor = Colors.gradientBlack
        fusumaTintColor = Colors.darkWhite
        fusumaTitleFont = UIFont(name: "Montserrat-semibold", size: 20)
        self.present(fusuma, animated: true, completion: nil)
    }
    
    func createSexPicker() {
        sexPicker.delegate = self
        self.sexTextField.inputView = sexPicker
        sexPicker.selectRow(0, inComponent: 0, animated: false)
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
        birthDatePicker.maximumDate = Date(timeIntervalSinceNow: (60*60*24*365*10*(-1)))
        self.birthDateTextField.inputView = birthDatePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButon = UIBarButtonItem(title: "Escolher", style: .done, target: self, action: #selector(dismissBirthPicker))
        toolbar.setItems([doneButon], animated: false)
        toolbar.isUserInteractionEnabled = true
        birthDateTextField.inputAccessoryView = toolbar
    }
    
    func getSexNumber(sex: String) -> Int {
        var sexNumber : Int?
        switch sex {
        case "Masculino":
            sexNumber = 1
            break
        case "Feminino":
            sexNumber = 2
            break
        default:
            sexNumber = 9
            break
        }
        return sexNumber!
    }
    
    func setUserDataHolders(name: String?, username: String?, birthDate: String?, sex: String?) {
        let userData = UserDefaults.standard.object(forKey: "logedUser") as! Data
        let logedUser = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
        if(name !=  nil){
            self.nameTextField.placeholderLbl.text = name
            logedUser.name = name
        }
        if(sex !=  nil){
            self.sexTextField.placeholderLbl.text = sex
            logedUser.sex = getSexNumber(sex: sex!)
        }
        if(birthDate !=  nil){
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let dateFormat = DateHelper.shared.getDate(fromString: birthDate!)
            let dateString = formatter.string(from: dateFormat!)
            self.birthDateTextField.placeholderLbl.text = dateString
            logedUser.birthDate = dateFormat
        }
        if(username != "empty"){
            self.userNameTextField.placeholderLbl.text = username
            logedUser.userName = username
        }
        
        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: logedUser)
        UserDefaults.standard.set(encodedUser, forKey: "logedUser")
        UserDefaults.standard.synchronize()
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
        if(sexTextField.text?.isEmpty)!{
            sex = getSexNumber(sex: sexTextField.placeholderLbl.text!)
        }else {
            sex = getSexNumber(sex: sexTextField.text!)
        }
        
        var birthDate : Date?
        if((birthDatePicker.date.timeIntervalSinceNow * -1) > (60*60*24*365*10)){
            birthDate = self.birthDatePicker.date
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
    
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        presenter?.sendPhotoToCloudinary(infoImage: image)
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
    
    }
    
    func fusumaCameraRollUnauthorized() {
        sendErrorMessage(message: "Camera não autorizada")
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

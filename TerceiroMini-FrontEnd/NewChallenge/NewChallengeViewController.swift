//
//  NewChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class NewChallengeViewController: UIViewController, NewChallengeView, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LoginCallerPortocol {
    
    
    var isMainScreen: Bool = false
    

    
    
    var challengePhotos : [Photo]?
    var state : ChallengeState?
    var challengeID : String?
    var challengeCover : UIImage?
    var challengeTheme : String?
    var data: ([Photo], Int)?
    var header: NewHeaderChallengeCollectionReusableView!
    @IBOutlet var mainCollectionView: UICollectionView!
    
    var challengeWinner : User?
    var endDate : Date?
    var isLogged = false
    var caller : LoginCallerPortocol?
    
    var showCompleteHeader: Bool = false {
        didSet {
            self.mainCollectionView?.collectionViewLayout.invalidateLayout()
        }
    }
    
    let defaultHeaderSize: CGFloat = 440

    
    var presenter : NewChallengePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init status bar
            initDarkStatusBar()
        //init nibs
            initNibs()
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        
        presenter = NewChallengePresenterImpl(challengeView: self)
        
        
    }

    //status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getChallengeHeader(challengeID: challengeID!, challengeState: state!)
        presenter?.getChallengeImages(challengeID: challengeID!)
        resolveState()
        
    }
    
    
    
    
    func setChallengePhotos(photos: [Photo]) {
        self.challengePhotos = photos
        self.mainCollectionView.reloadData()
    }
    func showCollectionPhotos() {
        self.mainCollectionView.reloadData()
    }
    func goToExpandPhotoView(parameter: ([Photo], Int)) {
        
        data = parameter
        performSegue(withIdentifier: "expandPhotoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "expandPhotoSegue"{
            
            if let dest = segue.destination as? ChallengeClosedViewController{
                dest.data = data
                dest.sender = self
            }
            
        }
    }
    
    func setHeader(theme: String, mainImageURL: String,numPhotos: Int){
        header.challengeLabel.text = theme
        let url = URL(string: mainImageURL)
        self.header.mainButton.isEnabled = true
        self.header.mainImage.sd_setImage(with: url, completed: nil)
        self.header.numberOfPhotos.text = "\(numPhotos) fotos"
        self.header.state = self.state!
    }
    
    
    func setHeaderStatusAsFinished(winner: User, photoWinner: Photo){
        header.statusImage.image = UIImage(named: "trophyBlackIcon")
        header.statusLabelLeadingToImage.isActive = false
        header.statusLabel.text = "Vencedor"
        header.mainButton.setTitle(winner.name, for: .normal)
        header.mainButton.isEnabled = true
        let profilePhotoUrl = URL(string: winner.profilePhotoUrl!)
        header.winnerPhotoBtn.clipsToBounds = true
        header.winnerPhotoBtn.layer.cornerRadius = header.winnerPhotoBtn.frame.height/2
        header.winnerPhotoBtn.sd_setImage(with: profilePhotoUrl, completed: nil)
        self.challengeWinner = winner
        
    }
    
    func setUserLoggedIn(isLogged: Bool){
      self.isLogged = true
    }
    
    func setHeaderButtonAsParticipating(){
        header.mainButton.isEnabled = true
        header.mainButton.setTitle("PARTICIPANDO", for: .normal)
        self.state = ChallengeState.participating
    }
    func setHeaderButtonAsParticipate() {
        header.mainButton.isEnabled = true
        header.mainButton.setTitle("PARTICIPAR", for: .normal)
        self.state = ChallengeState.open
    }
    
    
    func setHeaderStatusAsTimer(endDate: Date){
        header.statusImage.image = UIImage(named: "clockBlackIcon")
        if(self.state == ChallengeState.notLogged){
            self.header.mainButton.setTitle("CADASTRE-SE", for: .normal)
        }
        self.endDate = endDate
        timerUpdate()
    }
    
    func setFeaturedCollectionMyClick(myClick: Photo?){
        header.myClick = myClick
        self.showCompleteHeader = true
        header.featuredCollectionView.reloadData()
    }
    
    func setFeaturedCollectionMyFavoriteClick(myFavoriteClick: Photo?){
        self.showCompleteHeader = true
        header.myFavoriteClick = myFavoriteClick
        header.featuredCollectionView.reloadData()
    }
    
    func showFeaturedCollectionView(){
        self.header.featuredCollectionView.isHidden = false
    }
    
    func timerUpdate(){
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimerLabelText), userInfo: nil, repeats: true)
    }
    
    @objc func setTimerLabelText(){
        let now = Date()
        header.statusLabel.text = self.endDate?.timeIntervalSince(now).format() ?? "erro"
    }
    
    func resolveState(){
        
        switch state {
        case .open?:
        //    header.mainButton.setTitle("PARTICIPAR", for: .normal)
            break
        case .participating?:
          //  header.mainButton.setTitle("PARTICIPANDO", for: .normal)
            break
        case .finished?:
            break
        default:
            break
        }
    }
    
    func showPhotoMenu(){
        
        let alert = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            self.takePhoto()
        }))
        
        alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { _ in
            self.getPhoto()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func goToProfileFromChallenge(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        vc.user = self.challengeWinner!
        vc.showCompleteHeader = true
        defaultStatusBar()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToRegisterScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "registerScreen") as! LoginPresentationViewController
        vc.loginProtocol = self.caller
        vc.loginProtocol?.isMainScreen = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            presenter?.sendPhotoToCloudinary(infoImage: img, challengeID: challengeID!)
            
        }
        else if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            presenter?.sendPhotoToCloudinary(infoImage: img, challengeID: challengeID!)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func getPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    func takePhoto() {
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func initDarkStatusBar(){
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            UIView.animate(withDuration: 0.8, animations: {
                statusBar.backgroundColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
            })
        }
    }
    func defaultStatusBar() {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = Colors.darkWhite
        }
    }
    
    func initNibs(){
        self.mainCollectionView.register(UINib(nibName:MainCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
    }
}

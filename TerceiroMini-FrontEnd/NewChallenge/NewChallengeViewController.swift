//
//  NewChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class NewChallengeViewController: UIViewController, NewChallengeView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    var challengePhotos : [Photo]?
    var state = ChallengeState.open
    var challengeID : String?
    var data: ([Photo], Int)?
    var header: NewHeaderChallengeCollectionReusableView!
    @IBOutlet var mainCollectionView: UICollectionView!
    
    var challengeWinner : User?
    var endDate : Date?
    var isLogged = false
    
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
        
        
        //apagar depois
        self.state = ChallengeState.open
      //  self.challengeID = "5a2163e44ab66300147b416d"
        presenter?.getChallengeHeader(challengeID: challengeID!, challengeState: state)
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
        UIImage.fetch(with: mainImageURL) { (image) in
            self.header.mainImage.image = image
        }
        self.header.numberOfPhotos.text = "\(numPhotos) fotos"
        self.header.state = self.state
    }
    
    func setHeaderStatusAsFinished(winner: User, photoWinner: Photo){
        header.statusImage.image = UIImage(named: "trophyBlackIcon")
        header.statusLabel.text = "Vencedor"
        self.challengeWinner = winner
        
    }
    
    func setUserLoggedIn(isLogged: Bool){
      self.isLogged = true
    }
    
    func setHeaderButtonAsParticipating(){
        header.mainButton.setTitle("PARTICIPANDO", for: .normal)
        self.state = ChallengeState.participating
    }
    
    func setHeaderStatusAsTimer(endDate: Date){
        header.statusImage.image = UIImage(named: "clockBlackIcon")
        self.endDate = endDate
        timerUpdate()
    }
    
    func setFeaturedCollectionMyClick(myClick: Photo?){
        header.myClick = myClick
        header.featuredCollectionView.reloadData()
    }
    
    func setFeaturedCollectionMyFavoriteClick(myFavoriteClick: Photo?){
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
        case .open:
        //    header.mainButton.setTitle("PARTICIPAR", for: .normal)
            break
        case .participating:
          //  header.mainButton.setTitle("PARTICIPANDO", for: .normal)
            break
        case .finished:
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let infoImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            presenter?.sendPhotoToCloudinary(infoImage: infoImage, challengeID: challengeID!)
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
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func initDarkStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    func initNibs(){
        self.mainCollectionView.register(UINib(nibName:MainCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
    }
}

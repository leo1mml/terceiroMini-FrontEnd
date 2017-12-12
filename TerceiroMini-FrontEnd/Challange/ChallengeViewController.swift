//
//  ChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, ChallengeView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    
    //var challengeImages : [String]!
    var challengePhotos : [Photo]?
    var presenter : ChallengePresenter?
    var header: HeaderChallengeCollectionReusableView!
    var challengeID : String?
    //passing data to other view
    var data: ([Photo], Int)?
    @IBOutlet weak var clicksLogoImage: UIImageView!
    @IBOutlet weak var noImagesWarningLabel: UILabel!
    
    
    @IBOutlet weak var mainCollectionView: UICollectionView!


    // - mainButton
    
    var state = ChallengeState.votation
    var endDate : Date?
    
    //status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //init status bar
            initDarkStatusBar()

        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        
        
        //initializing nibs
        self.mainCollectionView.register(UINib(nibName:MainCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)

        presenter = ChallengePresenterImpl(challengeView: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        challengeID = "5a2163e44ab66300147b416d"
        presenter?.getChallengeHeader(challengeID: challengeID!)
        presenter?.getChallengeImages(challengeID: challengeID!)
        
        
        
    }
    
    func resolveState(){
        
        performSegue(withIdentifier: "profileSegue", sender: self)
    }
 

    
    func goToExpandoPhotoView(parameter: ([Photo], Int)) {
        
        data = parameter
        performSegue(withIdentifier: "expandPhotoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "expandPhotoSegue"{
            
            if let dest = segue.destination as? ChallengeClosedViewController{
                dest.data = data
            }
            
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
            //change status to participating
           
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func changeMainPhoto() {
        
    }
    
    func changeScreen() {
        
    }
    
    func showTimer() {
        
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
    
    
    
    func setHeader(theme: String, endDate: Date, mainImageURL: String,numPhotos: Int) {
        header.challengeLabel.text = theme
        UIImage.fetch(with: mainImageURL) { (image) in
            self.header.mainImage.image = image
        }
        self.header.numberOfPhotos.text = "\(numPhotos) fotos"
        self.endDate = endDate
        timerUpdate()
        
    }
    
    func timerUpdate(){
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimerLabelText), userInfo: nil, repeats: true)
    }
    
    @objc func setTimerLabelText(){
        let now = Date()
        header.statusLabel.text = self.endDate?.timeIntervalSince(now).format() ?? "erro"
    }
    
    func setChallengeState(state: ChallengeState) {
        self.state = state
        
        switch state {
        case .votation:
            //mudar label para periodo de votacao
            //atualizar tempo pegando do banco
            
            print("entrei")
            
            
            break
        case .finished:
            //get winner and change main button
            break
        default:
            //get timer
            break
        }
    }
    
    
    func initDarkStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    
    func setChallengePhotos(photos: [Photo]) {
        self.challengePhotos = photos
    }
    
    func showCollectionPhotos() {
        self.mainCollectionView.reloadData()
    }
    
    func showChallengeWinner(winner: User) {
        
    }
    
    func showFeaturedCollectionView(){
        self.header.featuredCollectionView.isHidden = false
    }
    func showNoImagesWarning(){
            self.noImagesWarningLabel.isHidden = false
            self.clicksLogoImage.isHidden = false
    }
    
    
}



enum ChallengeState {
    case open
    case votation
    case finished
    case participating
}

@IBDesignable
class LeftAlignedIconButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
    }
}

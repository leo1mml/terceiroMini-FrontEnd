//
//  ChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, ChallengeView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    var challengeImages : [String]!

    var presenter : ChallengePresenter?
    var header: HeaderChallengeCollectionReusableView!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!

    

    // - mainButton
    
    var state = ChallengeState.votation
    
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

        resolveState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            presenter?.getChallengeHeader()
    }
    
    func resolveState(){
        
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
 
    @IBAction func mainButtonAction(_ sender: LeftAlignedIconButton) {
        
        switch state {
        case .finished:
            //levar para o perfil do vencedor
            break
        case .participating:
            //colocar label
            break
        default:
            
            showPhotoMenu()
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
            presenter?.sendPhotoToCloudinary(infoImage: infoImage)
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
    
    
    
    func setHeader(theme: String, endDate: Date, mainImageURL: String) {
        header.challengeLabel.text = theme
        UIImage.fetch(with: mainImageURL) { (image) in
            self.header.mainImage.image = image
        }
        let now = Date()
        header.statusLabel.text = "\(now.timeIntervalSince(endDate))"
        
        
    }
    
    
    
    
    
    func initDarkStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
}

enum ChallengeState {
    case open
    case votation
    case finished
    case participating
}

extension UIImageView{
    func addChallengeGradientLayer(frame: CGRect, colors: [UIColor] ){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
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

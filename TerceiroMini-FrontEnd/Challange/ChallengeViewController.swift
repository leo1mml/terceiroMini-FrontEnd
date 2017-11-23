//
//  ChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, ChallengeView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    var presenter : ChallengePresenter?
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var numberOfPhotos: UILabel!
    @IBOutlet weak var ChallengeName: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
    //Constraints that change size
    // - statusLabel
    @IBOutlet weak var statusLabelTimerConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabelWinnerContraint: NSLayoutConstraint!
    // - mainButton
    
    var state = ChallengeState.open
    
    let startingGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    let middleGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:0.4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ChallengePresenterImpl()
        
        mainImage.addChallengeGradientLayer(frame: view.bounds, colors: [startingGradientColor,middleGradientColor,.white])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resolveState(state: state)
        
        
    }
    
    func resolveState(state : ChallengeState){
        
        switch state {
        case .votation:
            //mudar label para periodo de votacao
            break
        case .finished:
            changeStatusLabelContraint(open: false)
            //get winner and change main button
            break
        default:
            changeStatusLabelContraint(open: true)
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
    
    func showPhotoMenu (){
        
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
           
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func changeStatusLabelContraint(open: Bool){
        if(open){
            statusLabelWinnerContraint.priority = UILayoutPriority(rawValue: 750)
            statusLabelTimerConstraint.priority = UILayoutPriority(rawValue: 1000)
        }else{
            statusLabelWinnerContraint.priority = UILayoutPriority(rawValue: 1000)
            statusLabelTimerConstraint.priority = UILayoutPriority(rawValue: 750)
        }
    }
    
    enum ChallengeState {
        case open
        case votation
        case finished
        case participating
        
    }
    
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

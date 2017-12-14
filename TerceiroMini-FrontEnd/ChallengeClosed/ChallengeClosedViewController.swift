//
//  ChallengeClosedViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeClosedViewController: UIViewController, ChallengeClosedView {
    
    
    
    var presenter: ChallengeClosedPresenter?
    
    @IBOutlet weak var escolherClickButton: CustomButtonClick!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    var images = [""]
    var imageIndex = 0
    var details = true
    var data: ([Photo], Int)?
    var myClick = false
    
    let colorGradient = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = ChallengeClosedPresenterImpl(challengeClosedView: self)
        
        var imagesList = [String]()
        for url in (data?.0)!{
            imagesList.append(url.url!)
        }
        
        self.images = imagesList
        self.imageIndex = (data?.1)!
        
        backgroundImage.addChallengeGradientLayer(frame: view.bounds, colors: [colorGradient, .clear, .clear,.clear])
        
        showOrHideDetails()
        
        escolherClickButton.layer.cornerRadius = 25
        escolherClickButton.clipsToBounds = true
        updatePhotoCount()
        
        showExpandImages()
        
        
        
        
        

    }
    
    func showExpandImages(){
        
        backgroundImage.image = UIImage(named: images[imageIndex])
        UIImage.fetch(with: images[imageIndex], completion: { (image) in
            self.backgroundImage.image = image
        })
        
        presenter?.checkIfChosenClick(currentPhoto: (self.data?.0[imageIndex])!)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
  
    
    @IBAction func escolherClickAction(_ sender: Any) {
        if (myClick){
            presenter?.unvote(photo: (self.data?.0[imageIndex])!)
        }else{
            presenter?.vote(photo: (self.data?.0[imageIndex])!)
        }
        
        
        
    }
    
    @IBAction func showReport(_ sender: Any) {
        presenter?.showReport()
    }
    
    
    @objc func handleTap(){
        
        showOrHideDetails()
    }

    
    func enableMyClickChosebuttonLabel(){
        self.escolherClickButton.setTitle("Meu Click", for: .normal)
        self.myClick = true
        
    }
    
    func enableMyFavoriteClickChosebuttonLabel(){
        self.escolherClickButton.setTitle("Meu Click Favorito", for: .normal)
        self.myClick = true
        
    }
    func enableChoseClickButton(){
        self.escolherClickButton.setTitle("Escolher Click", for: .normal)
        self.myClick = false
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            if (imageIndex > 0){
                imageIndex -= 1
                backgroundImage.image = UIImage(named: images[imageIndex])
                UIImage.fetch(with: images[imageIndex], completion: { (image) in
                    self.backgroundImage.image = image
                })
                presenter?.checkIfChosenClick(currentPhoto: (self.data?.0[imageIndex])!)
                if(details){
                    showOrHideDetails()
                }
            }
            
            
            
        } else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if (imageIndex < images.count-1){
                imageIndex += 1
                backgroundImage.image = UIImage(named: images[imageIndex])
                UIImage.fetch(with: images[imageIndex], completion: { (image) in
                    self.backgroundImage.image = image
                })
                presenter?.checkIfChosenClick(currentPhoto: (self.data?.0[imageIndex])!)
            }
            
            if(details){
                showOrHideDetails()
            }
            
        }
        updatePhotoCount()
    }
    
    
    func showOrHideDetails(){
        
        if(details){
            
            UIView.animate(withDuration: 0.5, animations: {
                self.reportButton.alpha = 0
                self.photoCount.alpha = 0
                self.closeButton.alpha = 0
                self.escolherClickButton.alpha = 0
                //removing gradient layer
                //self.backgroundImage.layer.sublayers = nil
            self.backgroundImage.layer.sublayers?.first?.opacity = 0
            })
            
            
            
            reportButton.isEnabled = false
            photoCount.isEnabled = false
            closeButton.isEnabled = false
            escolherClickButton.isEnabled = false
            
          //  backgroundImage.layer.sublayers = nil
            
            self.details = false
        }else{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.reportButton.alpha = 1
                self.photoCount.alpha = 1
                self.closeButton.alpha = 1
                self.escolherClickButton.alpha = 1
                self.backgroundImage.layer.sublayers?.first?.opacity = 1
                
            })
            
            reportButton.isEnabled = true
            photoCount.isEnabled = true
            closeButton.isEnabled = true
            escolherClickButton.isEnabled = true
            
            
            self.details = true
        }
        
    }
    
    func showCurrentClick() {
        
    }
    
    func showAlert(){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = UIColor.black
        alert.addAction(UIAlertAction(title: "FORA DO TEMA", style: .default, handler: { _ in
            
        }))
        
        alert.addAction(UIAlertAction(title: "DENUNCIAR CLICK", style: .default, handler: { _ in
            
        }))

        alert.addAction(UIAlertAction.init(title: "CANCELAR", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func updatePhotoCount(){
        photoCount.text = "\(imageIndex+1)/\(images.count)"
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

@IBDesignable
class CustomButtonClick: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
    }
}

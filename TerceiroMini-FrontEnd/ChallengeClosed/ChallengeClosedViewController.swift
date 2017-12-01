//
//  ChallengeClosedViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeClosedViewController: UIViewController {

    @IBOutlet weak var escolherClickButton: CustomButtonClick!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    var images = ["pombo","pombo","pombo","pombo","pombo","pombo","pombo"]
    var imageIndex = 0
    var details = false
    
    
    let colorGradient = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding itens
        reportButton.isHidden = true
        photoCount.isHidden = true
        closeButton.isHidden = true
        escolherClickButton.isHidden = true
        
        
        
        

        escolherClickButton.layer.cornerRadius = 25
        escolherClickButton.clipsToBounds = true
        updatePhotoCount()
        
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
 
    }
    
    @IBAction func showReport(_ sender: Any) {
        showReport()
    }
    
    
    @objc func handleTap(){
        
        showOrHideDetails()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            if (imageIndex > 0){
                imageIndex -= 1
                backgroundImage.image = UIImage(named: images[imageIndex])
                
                if(details){
                    showOrHideDetails()
                }
            }
            
            
            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if (imageIndex < images.count-1){
                imageIndex += 1
                backgroundImage.image = UIImage(named: images[imageIndex])
                
            }
            
            if(details){
                showOrHideDetails()
            }
            
        }
        updatePhotoCount()
    }
    
    
    func showOrHideDetails(){
        
        if(details){
            reportButton.isHidden = true
            photoCount.isHidden = true
            closeButton.isHidden = true
            escolherClickButton.isHidden = true
            
            //removing gradient layer
            backgroundImage.layer.sublayers = nil
            
            self.details = false
        }else{
            reportButton.isHidden = false
            photoCount.isHidden = false
            closeButton.isHidden = false
            escolherClickButton.isHidden = false
            backgroundImage.addChallengeGradientLayer(frame: view.bounds, colors: [colorGradient, .clear, .clear,.clear])
            
            self.details = true
        }
        
    }
    
    func showReport(){

        
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

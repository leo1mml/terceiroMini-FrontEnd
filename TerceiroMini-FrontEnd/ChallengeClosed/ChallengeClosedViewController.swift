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
    var navigationProtocol : NavigateInAppProtocol?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var escolherClickButton: CustomButtonClick!
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    var sender: UIViewController?
    var images = [""]
    var imageIndex = 0
    var details = true
    var data: ([Photo], Int)?
    var myFavoriteClick = false
    var myClick : Bool? = false
    
    let colorGradient = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = ChallengeClosedPresenterImpl(challengeClosedView: self)
        
        self.scrollView.delegate = self
        
        var imagesList = [String]()
        for url in (data?.0)!{
            imagesList.append(url.url!)
        }
        
        self.images = imagesList
        self.imageIndex = (data?.1)!
        
        self.initializeScroll(index: imageIndex)
        
        escolherClickButton.layer.cornerRadius = 25
        escolherClickButton.clipsToBounds = true
        updatePhotoCount()
        
        showOrHideDetails()
        
        presenter?.checkIfChosenClick(currentPhoto: (self.data?.0[imageIndex])!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        initDarkStatusBar()
//    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func initDarkStatusBar(){
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            UIView.animate(withDuration: 0.8, animations: {
                statusBar.backgroundColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
            })
        }
    }
    
    
    @IBAction func escolherClickAction(_ sender: Any) {
        if !myClick!{
            if (myFavoriteClick){
                presenter?.unvote(photo: (self.data?.0[imageIndex])!)
            }else{
                presenter?.vote(photo: (self.data?.0[imageIndex])!)
            }
        }
        
    }
    
    @IBAction func showReport(_ sender: Any) {
        if(myClick)!{
            createExcludeAlert()
        }else{
            presenter?.showReport()
        }
    }
    
    func createExcludeAlert(){
        let title = "Excluir foto?"
        let message = "Você tem certeza que deseja excluir esta foto?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.presenter?.excludePhoto()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleTap(){
        
        showOrHideDetails()
    }
    
    func enableMyClickChosebuttonLabel(){
        self.escolherClickButton.setTitle("MEU CLICK", for: .normal)
        self.myFavoriteClick = false
        self.reportButton.setImage(UIImage(named: "lixo"), for: .normal)
        self.myClick = true
    }
    
    func enableMyFavoriteClickChosebuttonLabel(){
        self.escolherClickButton.setTitle("MEU CLICK FAVORITO", for: .normal)
        self.myFavoriteClick = true
        self.myClick = false
        
    }
    func enableChoseClickButton(){
        self.escolherClickButton.setTitle("ESCOLHER CLICK", for: .normal)
        self.myFavoriteClick = false
        self.myClick = false
        self.reportButton.setImage(UIImage(named: "flag-icon"), for: .normal)
    }
    
    func showOrHideDetails(){
        
        if(details){
            
            UIView.animate(withDuration: 0.3, animations: {
                self.photoCount.alpha = 0
                self.closeButton.alpha = 0
                self.escolherClickButton.alpha = 0
                self.reportButton.alpha = 0
                //removing gradient layer
                if self.scrollView.subviews.count != 0 {
                    self.scrollView.subviews[self.imageIndex].layer.sublayers?.first?.opacity = 0
                }
            })
            
            escolherClickButton.isEnabled = false
            photoCount.isEnabled = false
            closeButton.isEnabled = false
            
            self.details = false
        }else{
            
            UIView.animate(withDuration: 0.5, animations: {
                
                if !(self.sender is ProfileViewController) {
                    self.escolherClickButton.alpha = 1
                    self.escolherClickButton.isEnabled = true
                }else {
                    self.myClick = true
                }
                self.reportButton.alpha = 1
                self.photoCount.alpha = 1
                self.closeButton.alpha = 1
                if self.scrollView.subviews.count != 0 {
                    self.scrollView.subviews[self.imageIndex].layer.sublayers?.first?.opacity = 1
                }
                
            })
            
            photoCount.isEnabled = true
            closeButton.isEnabled = true
            
            self.details = true
        }
        
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
    
    func dissmissAndReloadParent() {
        if(self.navigationController == nil){
            self.dismiss(animated: true, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: true)
            if(sender?.isKind(of: NewChallengeViewController.self))!{
                (sender as! NewChallengeViewController).state = ChallengeState.open
            }
        }
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
//    @objc func canRotate() -> Void {}
    
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

//
//  ChallengeClosedViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import SDWebImage
import Hero

class ChallengeClosedViewController: UIViewController, ChallengeClosedView {
 
    var presenter: ChallengeClosedPresenter?
    var navigationProtocol : NavigateInAppProtocol?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var escolherClickButton: CustomButtonClick!
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    var sender: UIViewController?
    var data: Photo?
    var imageIndex = 0
    var imagesCount = 0
    
    var details = true
    var myFavoriteClick = false
    var myClick : Bool? = false
    
    let colorGradient = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = ChallengeClosedPresenterImpl(challengeClosedView: self)
        
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        let url = URL(string: (data?.url)!)
        imageView.sd_setImage(with: url, completed: nil)
        imageView.heroID = (data?.url)!
        
        escolherClickButton.layer.cornerRadius = 25
        escolherClickButton.clipsToBounds = true
        updatePhotoCount()
        
        showOrHideDetails()
        
        presenter?.checkIfChosenClick(currentPhoto: (self.data)!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.scrollView.zoomScale = self.scrollView.minimumZoomScale
        self.details = true
        showOrHideDetails()
    }
    
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
                presenter?.unvote(photo: (self.data)!)
            }else{
                presenter?.vote(photo: (self.data)!)
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
                self.imageView.removeChallengeGradientLayer()
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
                //adding gradient layer
                self.imageView.addChallengeGradientLayer(frame: self.view.bounds, colors: [self.colorGradient, .clear, .clear, .clear, .clear])
                
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
        photoCount.text = "\(imageIndex+1)/\(imagesCount)"
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
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: nil)
        let progress = translation.y / 2 / self.view.bounds.height
        
        switch sender.state {
        case .began:
            hero_dismissViewController()
            break
        case .changed:
            Hero.shared.update(progress)
            
            let currentPos = CGPoint(x: translation.x + imageView.center.x, y: translation.y + imageView.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
            break
        default:
            if progress + sender.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
            break
        }
        
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

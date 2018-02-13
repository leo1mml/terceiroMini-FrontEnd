//
//  NewChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import Fusuma
import NotificationBannerSwift

class NewChallengeViewController: UIViewController, NewChallengeView, UINavigationControllerDelegate, LoginCallerPortocol, FusumaDelegate {
    
    
    var isMainScreen: Bool = false
    

    
    var challenge : Challenge?
    var challengePhotos : [Photo]?
    var state : ChallengeState?
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
        if(UserDefaults.standard.string(forKey: "token") == nil){
            self.state = .notLogged
        }
        if((challenge?.endDate)! < Date()){
            self.state = .finished
        }
        if(self.state == nil || self.state != .publishingPhoto || self.state == .notLogged || self.state == .finished){
            presenter?.getChallengeHeader(challenge: challenge!)
            presenter?.getChallengeImages(challengeID: (challenge?.id)!)
        }
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
            
            if let dest = segue.destination as? ChallengeClosedPageViewController{
                dest.data = data
                dest.sender = self
            }
            
        }
    }
    
    func setHeader(theme: String, mainImageURL: String,numPhotos: Int){
        header.challengeLabel.text = theme
        let url = URL(string: mainImageURL)
        if(self.state == ChallengeState.notLogged){
            self.header.mainButton.isEnabled = true
        }
        self.header.mainImage.sd_setImage(with: url, completed: nil)
        self.header.numberOfPhotos.text = "\(numPhotos) fotos"
        if(self.state != nil){
            self.header.state = self.state!
            resolveState()
        }
    }
    
    
    func setHeaderStatusAsFinished(winner: User){
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
      self.isLogged = isLogged
    }
    
    func setHeaderButtonAsParticipating(){
        header.mainButton.isEnabled = true
        header.mainButton.setTitle("PARTICIPANDO", for: .normal)
        self.header.featuredCollectionView.reloadData()
        self.state = ChallengeState.participating
    }
    func setHeaderButtonAsParticipate() {
        header.mainButton.isEnabled = true
        header.mainButton.setTitle("PARTICIPAR", for: .normal)
        self.state = ChallengeState.open
    }
    
    func setHeaderButtonAsNotLogged(){
        header.mainButton.isEnabled = true
        header.mainButton.setTitle("CADASTRE-SE", for: .normal)
    }
    
    
    func setHeaderStatusAsTimer(endDate: Date){
        header.statusImage.image = UIImage(named: "clockBlackIcon")
        self.endDate = endDate
        timerUpdate()
        header.featuredCollectionView.reloadData()
    }
    
    func setFeaturedCollectionMyClick(myClick: Photo?){
        header.myClick = myClick
        self.showCompleteHeader = true
        self.header.featuredCollectionView.isHidden = false
        header.featuredCollectionView.reloadData()
    }
    
    func setFeaturedCollectionMyFavoriteClick(myFavoriteClick: Photo?){
        self.showCompleteHeader = true
        header.myFavoriteClick = myFavoriteClick
        self.header.featuredCollectionView.isHidden = false
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
            setHeaderButtonAsParticipate()
            break
        case .participating?:
            setHeaderButtonAsParticipating()
            break
        case .finished?:
            break
        case .notLogged?:
            setHeaderButtonAsNotLogged()
            break
        case .publishingPhoto?:
            break
            
        default:
            break
        }
    }
    
    func setState(state: ChallengeState) {
        self.state = state
        resolveState()
    }
    
    func showPhotoMenu(){
        
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
        vc.isChallengeFlow = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        self.header.mainButton.setTitle("PUBLICANDO...", for: .normal)
        self.header.mainButton.isEnabled = false
        self.state = .publishingPhoto
        presenter?.sendPhotoToCloudinary(infoImage: image, challengeID: (self.challenge?.id)!)
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        let banner = NotificationBanner(title: "Biblioteca não autorizada", subtitle: "", style: .info)
        banner.show()
        
    }
    
    
    
    func initDarkStatusBar(){
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
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
    
    func reloadData() {
        self.header.featuredCollectionView.reloadData()
        self.mainCollectionView.reloadData()
    }
}

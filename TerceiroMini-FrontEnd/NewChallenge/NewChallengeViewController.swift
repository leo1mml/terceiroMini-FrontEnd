//
//  NewChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class NewChallengeViewController: UIViewController, NewChallengeView {

    
    
    var challengePhotos : [Photo]?
    var state : ChallengeState?
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
        self.state = ChallengeState.finished
        self.challengeID = "5a2163e44ab66300147b416d"
        presenter?.getChallengeHeader(challengeID: challengeID!, challengeState: state!)
        presenter?.getChallengeImages(challengeID: challengeID!)
        
        
    }
    
    func setChallengePhotos(photos: [Photo]) {
        self.challengePhotos = photos
        self.mainCollectionView.reloadData()
    }
    func showCollectionPhotos() {
        self.mainCollectionView.reloadData()
    }
    
    func setHeader(theme: String, mainImageURL: String,numPhotos: Int){
        header.challengeLabel.text = theme
        UIImage.fetch(with: mainImageURL) { (image) in
            self.header.mainImage.image = image
        }
        self.header.numberOfPhotos.text = "\(numPhotos) fotos"
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
    
    func timerUpdate(){
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimerLabelText), userInfo: nil, repeats: true)
    }
    
    @objc func setTimerLabelText(){
        let now = Date()
        header.statusLabel.text = self.endDate?.timeIntervalSince(now).format() ?? "erro"
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

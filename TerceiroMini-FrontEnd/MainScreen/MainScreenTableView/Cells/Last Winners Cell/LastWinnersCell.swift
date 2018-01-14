//
//  LastWinnersCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class LastWinnersCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LastWinnersView {

    var presenter : LastWinnersPresenter?
    var navigationProtocol: NavigateInAppProtocol?
    
    @IBOutlet weak var lastWinnersCollectionView : UICollectionView!
    
    var challenges : [Challenge]?
    var users : [User]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = LastWinnersPresenterImp(self)
        presenter?.fetchLastChallenges()
        self.backgroundColor = Colors.darkWhite
        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challenges?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastWinner", for: indexPath) as! WinnerCollectionViewCell
        cell.photoImage.image = nil
        cell.profilePhoto.image = nil
        cell.nameLabel.text = ""
        cell.challenge = challenges?[indexPath.row]
        if indexPath.row <= ((users?.count) ?? 0 - 1){
         cell.user = users?[indexPath.row]
        }
        styleProfilePhotoImage(winnerProfilePhoto: cell.profilePhoto)
        styleWinnerImage(winnerPhoto: cell.photoImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let challenge = challenges?[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! WinnerCollectionViewCell
        cell.photoImage.heroID = challenge?.id
        cell.profilePhoto.heroID = "profilePhoto" + (challenge?.id)!
        navigationProtocol?.goToChallenge(with: (challenge?.id)!, coverImage: cell.photoImage.image!, challengeTitle: (challenge?.theme)!, state: .finished)
    }
    
    
    func styleWinnerImage(winnerPhoto: UIImageView) {
        winnerPhoto.layer.masksToBounds = true
        winnerPhoto.layer.cornerRadius = 10
        let blurEffect = UIBlurEffect(style: .dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = winnerPhoto.bounds
        blurEffectView.alpha = 0.4
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        winnerPhoto.addSubview(blurEffectView)
    }
    func styleProfilePhotoImage(winnerProfilePhoto: UIImageView) {
        winnerProfilePhoto.layer.masksToBounds = true
        winnerProfilePhoto.layer.cornerRadius = winnerProfilePhoto.frame.size.width/2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func appendNewUser(user: User) {
        if(self.users == nil){
            self.users = [User]()
        }
        DispatchQueue.main.async {
            self.users?.append(user)
            self.lastWinnersCollectionView.reloadData()
        }
        
    }
    
    func appendChallenges(challenges: [Challenge]) {
        DispatchQueue.main.async {
            self.challenges = challenges
            self.presenter?.fetchWinnerFor(challenges: challenges)
        }
    }
}

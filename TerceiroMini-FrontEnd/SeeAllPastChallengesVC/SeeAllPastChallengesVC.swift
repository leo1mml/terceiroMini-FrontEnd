//
//  SeeAllPastChallengesVC.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 06/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class SeeAllPastChallengesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SeeAllPastChallengesView {
    

    @IBOutlet weak var allWinnersCollectionView: UICollectionView!
    
    var challenges : [Challenge]?
    var users : [User]?
    
    var presenter : SeeAllPastChallengesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SeeAllPastChallengesPresenterImp(self)
        presenter?.fetchLastChallenges()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
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
        cell.user = users?[indexPath.row]
        styleProfilePhotoImage(winnerProfilePhoto: cell.profilePhoto)
        styleWinnerImage(winnerPhoto: cell.photoImage)
        return cell
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func appendNewUser(user: User) {
        if(self.users == nil){
            self.users = [User]()
        }
        DispatchQueue.main.async {
            self.users?.append(user)
            self.allWinnersCollectionView.reloadData()
        }
        
    }
    
    func appendChallenges(challenges: [Challenge]) {
        DispatchQueue.main.async {
            self.challenges = challenges
            self.presenter?.fetchWinnerFor(challenges: challenges)
        }
    }
    
    @IBAction func disappear(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

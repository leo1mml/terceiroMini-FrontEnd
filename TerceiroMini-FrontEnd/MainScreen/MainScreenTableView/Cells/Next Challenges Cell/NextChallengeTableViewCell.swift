//
//  NextChallengeTableViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 18/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class NextChallengeTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NextChallengesCellView {
    
    var presenter : NextChallengesCellPresenter?
    
    var challenges : [Challenge]?
    
    @IBOutlet weak var nextChallengesCollectionView : UICollectionView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = NextChallengesCellPresenterImp(self)
        presenter?.fetchChallenges()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challenges?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nextChallenge", for: indexPath) as! NextChallengesCollectionViewCell
        
        cell.dateLabel.text = ""
        cell.themeImage.image = nil
        cell.themeLabel.text = ""
        cell.challenge = challenges?[indexPath.row]
        styleNextChallengeView(view: cell.containerView)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func styleNextChallengeView (view: UIView) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func updateChallenges(challenges: [Challenge]) {
        self.challenges = challenges
        self.nextChallengesCollectionView.reloadData()
    }

}

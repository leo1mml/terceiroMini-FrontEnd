//
//  OpenChallengesTableViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import Hero

class OpenChallengesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, OpenChallengesCellView{
    
    
    
    var presenter : OpenChallengesCellPresenter?
    var navigateInAppDelegate: NavigateInAppProtocol?
    
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var collectionView : UICollectionView!
    var challenges : [Challenge]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = collectionView.collectionViewLayout as! ChallengesFlowLayout
        layout.invalidateLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.presenter = OpenChallengesCellPresenterImp(openChallengesCellView: self)
        presenter?.fetchChallenges()
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 335, height: 355)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 8
        return self.challenges?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as! ChallengeCollectionViewCell
        cell.numPhotosLabel.text = "44 fotos"
        cell.themeImage.image = nil
        cell.layer.cornerRadius = 10
        cell.challenge = challenges?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChallengeCollectionViewCell
        if(challenges != nil){
            cell.themeImage.heroID = challenges?[indexPath.row].id
            cell.clockView.heroID = "clock" + (challenges?[indexPath.row].id)!
            self.navigateInAppDelegate?.goToChallenge(with: (challenges?[indexPath.row])!, coverImage: cell.themeImage.image!)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollCenter = scrollView.contentOffset.x / (collectionView.frame.width * 0.89333)
        pageControl.currentPage = Int(round(scrollCenter))
        
        
    }

    
    func reloadCollectionView(with challenges: [Challenge]) {
        DispatchQueue.main.async {
            self.challenges = challenges
            self.collectionView.reloadData()
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

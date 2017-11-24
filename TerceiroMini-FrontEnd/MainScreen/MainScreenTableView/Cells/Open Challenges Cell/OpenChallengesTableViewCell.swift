//
//  OpenChallengesTableViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class OpenChallengesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = collectionView.collectionViewLayout as! ChallengesFlowLayout
        layout.invalidateLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 335, height: 355)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 8
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as! ChallengeCollectionViewCell
        cell.numPhotosLabel.text = "44 fotos"
        cell.themeImage.image = UIImage(named: "pombo")
        cell.layer.cornerRadius = 10
        cell.themeLabel.text = "Pombo"
    
        
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollCenter = scrollView.contentOffset.x / (collectionView.frame.width * 0.89333)
        pageControl.currentPage = Int(round(scrollCenter))
        scrollView.decelerationRate = 0.8
        
    }

    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
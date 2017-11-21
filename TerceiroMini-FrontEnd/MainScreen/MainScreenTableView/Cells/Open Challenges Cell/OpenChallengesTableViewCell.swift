//
//  OpenChallengesTableViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class OpenChallengesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var collectionView : UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 10
        return 10
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
        let scrollDidPass = scrollView.contentOffset.x / 355
        pageControl.currentPage = Int(scrollDidPass)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

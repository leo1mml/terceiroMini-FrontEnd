//
//  PerfilViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 16/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileView, UICollectionViewDelegate, UICollectionViewDataSource {

    var presenter: ProfilePresenter?
    var holder: ProfileUserHolder?
    var amountTrophy: Int!
    
    @IBOutlet weak var collectionProfile: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ProfilePresenterImpl(profileView: self)
        presenter?.loadData()
        
        amountTrophy = 0
        
        self.collectionProfile.delegate = self
        self.collectionProfile.dataSource = self
        
    }
    
    func receiveDatas(profileUserHolder: ProfileUserHolder) {
        holder = profileUserHolder
        collectionProfile.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if holder == nil {
            return 0
        }
        return holder?.cellHolders.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.themeLabel.text = holder?.cellHolders[indexPath.row].theme
        
        let startingGradientColor = UIColor(red: 0.15, green: 0.18, blue: 0.19, alpha: 1)
        
        cell.backgroundImage.addChallengeGradientLayer(frame: view.bounds, colors: [.clear, .clear, startingGradientColor])
        
        cell.backgroundImage.image = holder?.cellHolders[indexPath.row].image
        cell.backgroundImage.contentMode = .scaleAspectFill
        
        cell.frame.size.width = 121
        cell.frame.size.height = 121
        
        if holder == nil {return cell}
        
        if holder!.cellHolders[indexPath.row].isWinner {
            cell.trophyImage.isHidden = false
        } else {
            cell.trophyImage.isHidden = true
            amountTrophy = amountTrophy + 1
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        var reusableView: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView: HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath) as! HeaderCollectionReusableView
            
            // valor temporario
            headerView.profileImage.image = holder?.image
            headerView.profileImage.contentMode = .scaleAspectFill
            
            headerView.profileImage.layer.cornerRadius = headerView.profileImage.frame.size.width/2
            headerView.profileImage.clipsToBounds = true
            
            headerView.profileBorderView.layer.cornerRadius = headerView.profileBorderView.frame.size.width/2
            headerView.profileBorderView.clipsToBounds = true
            
            headerView.profileBorderView.layer.borderWidth = 2
            headerView.profileBorderView.layer.borderColor = UIColor.black.cgColor
            
            headerView.profileNameLabel.text = holder?.name
            headerView.profileUserName.text = holder?.username
            headerView.profileTrophyNumberLabel.text = "\(amountTrophy)"
            headerView.profilePhotoNumberLabel.text = "\(holder?.cellHolders.count ?? 0)"
            
            reusableView = headerView
        }
        
        return reusableView!
        
    }
    
}

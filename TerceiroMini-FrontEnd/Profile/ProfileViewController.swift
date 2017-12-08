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
    var holder = ProfileUserHolder(image: UIImage(), name: "", username: "", amountPhotos: 0, amountTrophy: 0)
    var cells = [ProfileCellHolder]()
    
    @IBOutlet weak var collectionProfile: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ProfilePresenterImpl(profileView: self)
        presenter?.loadData(id: "5a21a303391838001482d1f2")
        
        self.collectionProfile.delegate = self
        self.collectionProfile.dataSource = self
        
    }
    
    func receiveDatas(profileUserHolder: ProfileUserHolder) {
        holder = profileUserHolder
        collectionProfile.reloadData()
    }
    
    func receiveCells(cells: [ProfileCellHolder]) {
        self.cells = cells
        collectionProfile.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (holder.amountPhotos)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.themeLabel.text = cells[indexPath.row].theme
        
        let startingGradientColor = UIColor(red: 0.15, green: 0.18, blue: 0.19, alpha: 1)
        
        cell.backgroundImage.addChallengeGradientLayer(frame: view.bounds, colors: [.clear, .clear, startingGradientColor])
        
        cell.backgroundImage.image = cells[indexPath.row].image
        cell.backgroundImage.contentMode = .scaleAspectFill
        
        cell.frame.size.width = 121
        cell.frame.size.height = 121
        
        if holder == nil {return cell}
        
        if (cells[indexPath.row].isWinner) {
            cell.trophyImage.isHidden = false
        } else {
            cell.trophyImage.isHidden = true
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        var reusableView: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView: HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath) as! HeaderCollectionReusableView
            
            // valor temporario
            headerView.profileImage.image = holder.image
            headerView.profileImage.contentMode = .scaleAspectFill
            
            headerView.profileImage.layer.cornerRadius = headerView.profileImage.frame.size.width/2
            headerView.profileImage.clipsToBounds = true

            headerView.profileBorderView.makeBorderAnimate()

            headerView.profileNameLabel.text = holder.name
            headerView.profileUserName.text = holder.username
            headerView.profileTrophyNumberLabel.text = "\(holder.amountTrophy)"
            headerView.profilePhotoNumberLabel.text = "\(holder.amountPhotos)"
            
            reusableView = headerView
        }
        
        return reusableView!
        
    }
    
}

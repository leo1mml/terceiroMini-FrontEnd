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
    
    @IBOutlet weak var collectionProfile: UICollectionView!
    
    // array de imagens
    var images: [UIImage]!
    
    // array de temas
    var temas = ["Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ProfilePresenterImpl(profileView: self)
        
        presenter?.loadImages()
        
        self.collectionProfile.delegate = self
        self.collectionProfile.dataSource = self
        
    }
    
    func erroLoadImages() {
        let alert = UIAlertView()
        alert.title = "Erro"
        alert.message = "Error loading images"
        alert.addButton(withTitle: "OK")
        alert.show()
    }

    func receiveImages(images: [UIImage]) {
        self.images = images
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images == nil {
            return 0
        }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.themeLabel.text = temas[indexPath.row]
        
        let startingGradientColor = UIColor(red: 0.15, green: 0.18, blue: 0.19, alpha: 1)
        
        cell.backgroundImage.addChallengeGradientLayer(frame: view.bounds, colors: [.clear, .clear, startingGradientColor])
        
        cell.backgroundImage.image = images[indexPath.row]
        cell.backgroundImage.contentMode = .scaleAspectFill
        
        cell.frame.size.width = 121
        cell.frame.size.height = 121
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        var reusableView: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView: HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath) as! HeaderCollectionReusableView
            
            // valor temporario
            headerView.profileImage.image = UIImage(named: "pombo")
            headerView.profileImage.contentMode = .scaleAspectFill
            
            headerView.profileImage.layer.cornerRadius = headerView.profileImage.frame.size.width/2
            headerView.profileImage.clipsToBounds = true
            
            headerView.profileBorderView.layer.cornerRadius = headerView.profileBorderView.frame.size.width/2
            headerView.profileBorderView.clipsToBounds = true
            
            headerView.profileBorderView.layer.borderWidth = 2
            headerView.profileBorderView.layer.borderColor = UIColor.black.cgColor
            
            reusableView = headerView
        }
        
        return reusableView!
        
    }
    
}

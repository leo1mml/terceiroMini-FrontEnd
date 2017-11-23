//
//  PerfilViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 16/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionProfile: UICollectionView!
    
    // array de imagens
    var images = ["pombo.jpg","pombo.jpg","pombo.jpg","pombo.jpg","pombo.jpg","pombo.jpg","pombo.jpg","pombo.jpg","pombo.jpg","pombo.jpg"]
    
    // array de temas
    var temas = ["Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo", "Pombo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionProfile.delegate = self
        self.collectionProfile.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.themeLabel.text = temas[indexPath.row]
        
        let startingGradientColor = UIColor(red: 0.15, green: 0.18, blue: 0.19, alpha: 1)
        
        cell.backgroundImage.addChallengeGradientLayer(frame: view.bounds, colors: [.clear, .clear, startingGradientColor])
        
        cell.backgroundImage.image = UIImage(named: images[indexPath.row])
        cell.backgroundImage.contentMode = .scaleAspectFill
        
        cell.frame.size.width = 121
        cell.frame.size.height = 121
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        var reusableView: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView: HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath) as! HeaderCollectionReusableView
            
            headerView.profileImage.image = UIImage(named: images[1])
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

extension UIImageView{
    func addChallengeGradientLayer(frame: CGRect, colors: [UIColor] ){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
}

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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        var reusableView: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView: HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath) as! HeaderCollectionReusableView
            
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

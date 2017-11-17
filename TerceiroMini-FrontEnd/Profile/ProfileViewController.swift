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
    //    @IBOutlet weak var profileBorderView: UIView!
    //    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionProfile.delegate = self
                
//        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
//        self.profileImage.clipsToBounds = true
//
//        self.profileBorderView.layer.cornerRadius = self.profileBorderView.frame.size.width/2
//        self.profileBorderView.clipsToBounds = true
//
//        self.profileBorderView.layer.borderWidth = 2
//        self.profileBorderView.layer.borderColor = UIColor.black.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath)
    }

}

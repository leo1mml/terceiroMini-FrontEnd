//
//  MainCollectionViewCell.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 23/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainCollectionViewCell"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var numberOfVotes: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernamePhoto: UIImageView!
    
    
    
}

//
//  PerfilViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 16/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController, ProfileView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var presenter: ProfilePresenter?
    var holder = ProfileUserHolder(imageUrl: "", name: "", username: "")
    var cells = [ProfileCellHolder]()
    var user : User? {
        didSet {
            presenter?.loadPhotos(id: (user?.id)!)
            presenter?.loadData(id: (user?.id)!, photos: photos)
            presenter?.loadHeader(id: (user?.id)!)
        }
    }
    
    var showCompleteHeader: Bool = false
    
    var isGradients = [Bool]()
    var photos = [Photo]()
    var data: ([Photo], Int)?
    var amountTrophy = 0
    
    @IBOutlet weak var collectionProfile: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var CVtopSpaceSmall: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenterImpl(profileView: self)
        self.collectionProfile.delegate = self
        self.collectionProfile.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if((self.user) != nil){
            presenter?.loadPhotos(id: (user?.id)!)
            presenter?.loadData(id: (user?.id)!, photos: photos)
            presenter?.loadHeader(id: (user?.id)!)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(showCompleteHeader){
            self.CVtopSpaceSmall.isActive = false
            self.backButton.isEnabled = true
            self.backButton.isHidden = false
        }
    }
    
    func initDarkStatusBar(){
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
        }
    }
    
    func initializeArrayIsGradients(){
        for _ in 0..<cells.count-(isGradients.count) {
            isGradients.append(false)
        }
    }
    
    func receivePhotos(photos: [Photo]) {

        self.photos = photos
        presenter?.loadData(id: (user?.id)!, photos: self.photos)
    }
    
    func receiveDatas(profileUserHolder: ProfileUserHolder) {
        holder = profileUserHolder
        collectionProfile.reloadData()
    }
    
    func receiveCells(cells: [ProfileCellHolder]) {
        self.cells = cells
        amountTrophy = 0
        self.initializeArrayIsGradients()
        collectionProfile.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (cells.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.themeLabel.text = cells[indexPath.row].theme
        
        if !isGradients[indexPath.row] {
            let startingGradientColor = UIColor(red: 0.15, green: 0.18, blue: 0.19, alpha: 1)
            cell.backgroundImage.addChallengeGradientLayer(frame: view.bounds, colors: [.clear, .clear, startingGradientColor])
            isGradients[indexPath.row] = true
        }
        
        let url = URL(string: photos[indexPath.row].url!)
        cell.backgroundImage.sd_setImage(with: url, completed: nil)
        
        cell.backgroundImage.contentMode = .scaleAspectFill
        
        cell.frame.size.width = 121
        cell.frame.size.height = 121
        
        if (cells[indexPath.row].isWinner) {
            cell.trophyImage.isHidden = false
            cell.themeLabel.isHidden = false
            amountTrophy += 1
        } else {
            cell.trophyImage.isHidden = true
            cell.themeLabel.isHidden = true
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        var reusableView: UICollectionReusableView? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView: HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath) as! HeaderCollectionReusableView
            if(holder.imageUrl != ""){
                let url = URL(string: holder.imageUrl)
                headerView.profileImage.sd_setImage(with:url, completed: nil)
                headerView.profileImage.contentMode = .scaleAspectFill
            }else {
                headerView.profileImage.image = UIImage(named: "profile-default")
            }
            
            
            headerView.profileImage.layer.cornerRadius = headerView.profileImage.frame.size.width/2
            headerView.profileImage.clipsToBounds = true

            headerView.profileBorderView.makeCircleBorderAnimate()

            headerView.profileNameLabel.text = holder.name
            headerView.profileUserName.text = holder.username
            headerView.profileTrophyNumberLabel.text = "\(amountTrophy)"
            headerView.profilePhotoNumberLabel.text = "\(cells.count)"
            
            reusableView = headerView
        }
        
        return reusableView!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        data = (self.photos, indexPath.row) as ([Photo], Int)
        performSegue(withIdentifier: "expandMyPhotoSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(!showCompleteHeader){
            return CGSize(width: collectionView.bounds.width, height: 270)
        }
        
        return CGSize(width: collectionView.bounds.width, height: 320)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        initDarkStatusBar()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "expandMyPhotoSegue"{
            if let dest = segue.destination as? ChallengeClosedViewController{
                dest.data = data
                dest.sender = self
            }
            
        }
    }
 
}

//
//  MainScreenViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class MainScreenViewController: UITableViewController, MainScreenView, NavigationAnimationsDelegate{
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var rightIcon: UIView!
    @IBOutlet weak var leftIcon: UIView!
    @IBOutlet weak var centerIcon: UIView!
    var pageViewController: NavigationViewController!
    var presenter : MainScreenPresenter?
    
    var lastOffsetX : CGFloat = 0.0

    @IBOutlet weak var pageViewContainer: UIView!
    
    override func viewDidLoad() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PageView") {
            self.pageViewController = vc as! NavigationViewController
            self.pageViewContainer.frame = pageViewController.view.frame
            self.pageViewContainer.addSubview(vc.view)
            self.pageViewController.delegateAnimations = self
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Animations methods
    
    func swipeMainToProfile() {
        UIView.animate(withDuration: 0.4) {
            self.logoImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.profileImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.profileImage.center = self.centerIcon.center
        }
    }
    
    func swipeProfileToMain() {
        UIView.animate(withDuration: 0.4) {
            self.logoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.logoImage.center = self.centerIcon.center
            self.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
    }
    
    func setFirstOffset(firstOffsetX: CGFloat) {
        self.lastOffsetX = firstOffsetX
    }
    
    func moveAndScaleItems(with contentOffset: CGPoint) {
        if(contentOffset.x == 0.0){
            return
        }
        
        
        let differenceOffsetX = abs(lastOffsetX - contentOffset.x)
        
        
        if(differenceOffsetX < 370){
            if(lastOffsetX > contentOffset.x){
                self.logoImage.center.x = (self.logoImage.center.x + differenceOffsetX * 0.4)
                self.profileImage.center.x = (self.profileImage.center.x + differenceOffsetX * 0.4)
            }else if (lastOffsetX < contentOffset.x) {
                
                self.logoImage.center.x = (self.logoImage.center.x - differenceOffsetX * 0.4)
                self.profileImage.center.x = (self.profileImage.center.x - differenceOffsetX * 0.4)
            }
            
        }
        
        self.lastOffsetX = contentOffset.x
        
        
        
    }
    
    func resizeItemForLess(view: UIView, offsetScroll: CGPoint) {
        
    }
    @IBAction func goToMainScreen(_ sender: Any) {
        self.pageViewController.goToPreviousPage()
    }
    
    @IBAction func goToProfile(_ sender: Any) {
        print(self.centerIcon.center.x)
        self.pageViewController.goToNextPage()
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

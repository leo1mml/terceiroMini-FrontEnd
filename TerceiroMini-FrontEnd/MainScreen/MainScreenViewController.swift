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
//        UIView.animate(withDuration: 0.4) {
//            self.logoImage.center = self.leftIcon.center
//            self.logoImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
//        }
    }
    
    func swipeProfileToMain() {
//        UIView.animate(withDuration: 0.4) {
//            self.logoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
//            self.logoImage.center = self.centerIcon.center
//        }
        
    }
    
    func swipeProfileToConfig() {
        
    }
    
    func swipeConfigToProfile() {
        
    }
    func setFirstOffset(firstOffsetX: CGFloat) {
        self.lastOffsetX = firstOffsetX
    }
    
    func moveAndScaleItems(with contentOffset: CGPoint) {
        if(contentOffset.x == 0.0){
            return
        }
        print("LAST OFFSET \(lastOffsetX)")
        print("CURRENT OFFSET \(contentOffset.x)")
        let differenceOffsetX = abs(lastOffsetX - contentOffset.x)
        print("DIFERENCE \(differenceOffsetX)")
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

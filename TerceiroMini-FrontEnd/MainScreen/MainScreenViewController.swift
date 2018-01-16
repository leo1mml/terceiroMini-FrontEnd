//
//  MainScreenViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

protocol NavigateInAppProtocol {
    func goToSeeAll()
    func instanceProfile()
    func goToChallenge(with challengeId: String, coverImage: UIImage, challengeTitle: String, state: ChallengeState)
    func goToAlertView()
    func goToLogin(vc: LoginViewController)
    func goToRegister(vc: RegisterViewController)
}

class MainScreenViewController: UITableViewController, MainScreenView, NavigationAnimationsDelegate, NavigateInAppProtocol{
    
   
    @IBOutlet weak var configButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var rightIcon: UIView!
    @IBOutlet weak var leftIcon: UIView!
    @IBOutlet weak var centerIcon: UIView!
    var pageViewController: NavigationViewController!
    var presenter : MainScreenPresenter?
    var viewControllerList : [UIViewController]?
    var loginDelegate : LoginCallerPortocol?
    
    var lastOffsetX : CGFloat = 0.0

    @IBOutlet weak var pageViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PageView") else {
            return
        }
        self.pageViewController = vc as! NavigationViewController
        self.pageViewContainer.frame = pageViewController.view.frame
        self.pageViewContainer.addSubview(vc.view)
        self.viewControllerList = self.pageViewController.viewControllerList

        self.view.backgroundColor = Colors.darkWhite
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(self.pageViewController.nextVCIdentifier == ""){
            self.profileImage.tintColor = .gray
        }
        self.pageViewController.delegateAnimations = self
        let mainScreen = self.pageViewController.viewControllerList[0] as! MainScreenTableViewController
        mainScreen.delegateNavigateInApp = self
        mainScreen.challengesCell.navigateInAppDelegate = self
        mainScreen.lastWinnersCell.navigationProtocol = self
        mainScreen.nextChallengesCell.navigationProtocol = self
        if(self.pageViewController.viewControllerList[1].restorationIdentifier == "Main"){
            self.configButton.isEnabled = false
            self.configButton.isHidden = true
            (self.pageViewController.viewControllerList[1] as! LoginPresentationViewController).navigationProtocol = self
            (self.pageViewController.viewControllerList[1] as! LoginPresentationViewController).loginProtocol?.isMainScreen = true
            (self.pageViewController.viewControllerList[1] as! LoginPresentationViewController).isChallengeFlow = false
        }
        defaultStatusBar()
        
    }
    
    func defaultStatusBar() {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = Colors.darkWhite
        }
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
            self.profileImage.tintColor = .black
            self.logoImage.tintColor = .gray
            self.configButton.center = self.rightIcon.center
        }
    }
    
    func swipeProfileToMain() {
        UIView.animate(withDuration: 0.4) {
            self.logoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.logoImage.center = self.centerIcon.center
            self.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.profileImage.tintColor = .gray
            self.logoImage.tintColor = .black
        }
        
    }
    
    func setInitialItemsPosition() {
        self.configButton.isEnabled = true
        self.configButton.isHidden = false
        self.configButton.center.x = self.view.frame.width + 125
        self.profileImage.center = self.rightIcon.center
        self.logoImage.center = self.centerIcon.center

        UIView.animate(withDuration: 0.001) {
            self.logoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.logoImage.tintColor = .black
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
                self.logoImage.center.x = (self.logoImage.center.x + differenceOffsetX * 0.42)
                self.profileImage.center.x = (self.profileImage.center.x + differenceOffsetX * 0.42)
                self.configButton.center.x = (self.configButton.center.x + differenceOffsetX * 0.42)
            }else if (lastOffsetX < contentOffset.x) {
                self.logoImage.center.x = (self.logoImage.center.x - differenceOffsetX * 0.42)
                self.profileImage.center.x = (self.profileImage.center.x - differenceOffsetX * 0.42)
                self.configButton.center.x = (self.configButton.center.x - differenceOffsetX * 0.42)
            }
            
        }
        self.lastOffsetX = contentOffset.x
    }
    
    @IBAction func goToMainScreen(_ sender: Any) {
        self.pageViewController.goToPreviousPage()
    }
    
    @IBAction func goToProfile(_ sender: Any) {
        print(self.centerIcon.center.x)
        self.pageViewController.goToNextPage()
    }
    
    @IBAction func goToConfig(_ sender: Any) {
        self.navigationController?.isHeroEnabled = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Opcoes") as! ConfigurationTableViewController
        vc.loginProtocol = self.pageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func goToSeeAll() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeeAllPastChallenges") as! SeeAllPastChallengesVC
        vc.navigationDelegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func instanceProfile() {
        self.pageViewController.viewControllerList[1] = (self.storyboard?.instantiateViewController(withIdentifier: "Profile"))!
        self.pageViewController.reloadInputViews()
    }
    
    func goToChallenge(with challengeId: String, coverImage: UIImage, challengeTitle: String, state: ChallengeState) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "challengeVC") as! NewChallengeViewController
        vc.challengeID = challengeId
        vc.challengeTheme = challengeTitle
        vc.challengeCover = coverImage
        vc.state = state
        vc.caller = self.pageViewController
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .fade
        self.navigationController?.show(vc, sender: self)
    }

    func goToAlertView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChallengeClosedAlert") as! ChallengeClosedAlertViewController
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.isHeroEnabled = false
        self.present(vc, animated: true, completion: nil)
    }
    
    func goToLogin(vc: LoginViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func goToRegister(vc: RegisterViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
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

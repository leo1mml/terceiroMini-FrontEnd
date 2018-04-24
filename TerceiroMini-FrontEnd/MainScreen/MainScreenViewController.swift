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
    func goToChallenge(with challenge: Challenge, coverImage: UIImage?)
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
    @IBOutlet weak var pageViewContainer: UIView!
    
    var pageViewController: NavigationViewController! //Reference to the pageViewController to manage some animations
    var presenter : MainScreenPresenter? // Presenter protocol instantiated in the viewDidLoad
    var viewControllerList : [UIViewController]? //viewController list to be managed by some methods
    var loginDelegate : LoginCallerPortocol? // Login delegate to show some log in pages
    
    var lastOffsetX : CGFloat = 0.0 // register of the last offset in the horizontal

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
    
    /**
      Handles the movement to the Profile Screen when the button is clicked
     */
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
    
    /**
     Handles the movement to the mainscreen when the button is clicked
     */
    func swipeProfileToMain() {
        UIView.animate(withDuration: 0.4) {
            self.logoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.logoImage.center = self.centerIcon.center
            self.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.profileImage.tintColor = .gray
            self.logoImage.tintColor = .black
        }
        
    }
    
    /**
     Sets the initial position of items.
     */
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
    
    /**
     Sets the first offset to use it later in calculations.
     */
    func setFirstOffset(firstOffsetX: CGFloat) {
        self.lastOffsetX = firstOffsetX
    }
    
    
    /**
     Function to move items and scale them while they're scrolled.
     
     - parameters:
        - contentOffset: content offset to resize the items acording to it.
     */
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
    
    // MARK: - Actions
    
    
    /**
     Function in Navigation protocol to return to mainScreen.
     
     - parameters:
        - sender: The button or any other trigger which should activate this protocol function.
     */
    @IBAction func goToMainScreen(_ sender: Any) {
        self.pageViewController.goToPreviousPage()
    }
    
    /**
     Navigate to the profile page.
     
     - parameters:
        - sender: The button or any other trigger which should activate this protocol function.
     */
    @IBAction func goToProfile(_ sender: Any) {
        print(self.centerIcon.center.x)
        self.pageViewController.goToNextPage()
    }
    
    
    /**
     Navigate to the configuration page.
     
     - parameters:
        - sender: The button or any other trigger which should activate this protocol function.
     */
    @IBAction func goToConfig(_ sender: Any) {
        self.navigationController?.isHeroEnabled = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Opcoes") as! ConfigurationTableViewController
        vc.loginProtocol = self.pageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Navigation Methods
    
    /**
     Navigate to the see all past challenges page.
     */
    func goToSeeAll() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeeAllPastChallenges") as! SeeAllPastChallengesVC
        vc.navigationDelegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /**
     Instantiate a profile view controller.
     */
    func instanceProfile() {
        self.pageViewController.viewControllerList[1] = (self.storyboard?.instantiateViewController(withIdentifier: "Profile"))!
        self.pageViewController.reloadInputViews()
    }
    
    /**
     Navigate to an specific challenge with the image preloaded.
     
     - parameters:
        - challenge: The challenge which should be displayed.
        - coverImage: The image of the challenge.
     */
    func goToChallenge(with challenge: Challenge, coverImage: UIImage?) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "challengeVC") as! NewChallengeViewController
        vc.challenge = challenge
        vc.challengeCover = coverImage
        vc.caller = self.pageViewController
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .fade
        self.navigationController?.show(vc, sender: self)
    }

    
    /**
     Navigate to an alert view when the challenge is closed already
     */
    func goToAlertView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChallengeClosedAlert") as! ChallengeClosedAlertViewController
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.isHeroEnabled = false
        self.present(vc, animated: true, completion: nil)
    }
    
    /**
     Navigate to the login page.
     
     - parameters:
        - vc: The LoginViewController instance.
     */
    func goToLogin(vc: LoginViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /**
     Navigate to the registration screen.
     
     - parameters:
        - vc: The RegisterViewController instance.
     */
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

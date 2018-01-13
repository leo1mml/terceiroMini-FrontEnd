//
//  NavigationViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 24/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

protocol NavigationAnimationsDelegate {
    func swipeMainToProfile()
    func swipeProfileToMain()
    func setInitialItemsPosition()
    func moveAndScaleItems(with contentOffset: CGPoint)
    func setFirstOffset(firstOffsetX: CGFloat)
}

class NavigationViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, LoginCallerPortocol {
    
    var isMainScreen: Bool {
        return true
    }
    
    lazy var viewControllerList:[UIViewController] = {
        let sb = UIStoryboard(name: "MainScreen", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "MainStoryboard")
        vc1.restorationIdentifier = "MainScreen"
        var vc2 : UIViewController?
        if let token = UserDefaults.standard.string(forKey: "token"){
            vc2 = sb.instantiateViewController(withIdentifier: "ProfileStoryboard")
            vc2?.restorationIdentifier = "Profile"
            NetworkManager.getUser(byToken: token, completion: { (me, err) in
                if(err == nil){
                    (vc2 as! ProfileViewController).user = me
                }
            })
        }else {
            vc2 = sb.instantiateViewController(withIdentifier: "Main")
            vc2?.restorationIdentifier = "Main"
            (vc2 as! LoginPresentationViewController).caller = self
            
        }
        return [vc1, vc2!]
    }()
    var pageViewScroll : UIScrollView?
    
    var vcIndex : Int = 0
    var nextVCIdentifier : String = ""
    var previousVCIdentifier : String = ""
    
    var delegateAnimations : NavigationAnimationsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        for v in self.view.subviews{
            if (v is UIScrollView){
                //                if v.isKindOfClass(UIScrollView){
                (v as! UIScrollView).delegate = self
                self.pageViewScroll = v as? UIScrollView
            }
        }
        delegateAnimations?.setFirstOffset(firstOffsetX: (pageViewScroll?.contentOffset.x)!)
        self.view.backgroundColor = Colors.darkWhite
        // Do any additional setup after loading the view.
    }
    override var canBecomeFirstResponder: Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.nextVCIdentifier = pendingViewControllers[0].restorationIdentifier!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(!completed){
            return
        }
        //self.currentPageIndex = self.lastPendingViewControllerIndex
        self.previousVCIdentifier = previousViewControllers[0].restorationIdentifier!
        
        if(self.previousVCIdentifier == "MainScreen" && self.nextVCIdentifier == "Profile" || self.nextVCIdentifier == "Main"){
            delegateAnimations?.swipeMainToProfile()
        } else if(self.previousVCIdentifier == "Main" || self.previousVCIdentifier == "Profile" && self.nextVCIdentifier == "MainScreen"){
            delegateAnimations?.swipeProfileToMain()
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateAnimations?.moveAndScaleItems(with: scrollView.contentOffset)
    }

    func goToNextPage(){
        
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else {return}
        
        setViewControllers([nextViewController], direction: .forward, animated: true) { (finished) in
            if(finished){
                self.delegateAnimations?.swipeMainToProfile()
            }
        }
        
//        //setViewControllers([nextViewController], direction: .forward, animated: true, completion: (){
//            delegateAnimations?.swipeMainToProfile()
        
    }
    
    
    func goToPreviousPage(){
        
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else {
            return
        }
        
        setViewControllers([previousViewController], direction: .reverse, animated: true) { (finished) in
            if(finished){
                 self.delegateAnimations?.swipeProfileToMain()
            }
        }
    }
    
    func loginFinishedSuccessfully() {
        let sb = UIStoryboard(name: "MainScreen", bundle: nil)
        let vc1 = self.viewControllerList[0]
        vc1.restorationIdentifier = "MainScreen"
        var vc2 : UIViewController?
        if let token = UserDefaults.standard.string(forKey: "token"){
            vc2 = sb.instantiateViewController(withIdentifier: "ProfileStoryboard")
            vc2?.restorationIdentifier = "Profile"
            NetworkManager.getUser(byToken: token, completion: { (me, err) in
                if(err == nil){
                    (vc2 as! ProfileViewController).user = me
                }
            })
        }else {
            vc2 = sb.instantiateViewController(withIdentifier: "Main")
            vc2?.restorationIdentifier = "Main"
            (vc2 as! LoginPresentationViewController).caller = self
            
        }
        self.viewControllerList = [vc1, vc2!]
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: { (completed) in
                self.delegateAnimations?.setInitialItemsPosition()
            })
        }
        // [vc1, vc2!]
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

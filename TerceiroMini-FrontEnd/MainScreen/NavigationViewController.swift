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
    func swipeProfileToConfig()
    func swipeConfigToProfile()
    func moveAndScaleItems(with contentOffset: CGPoint)
    func setFirstOffset(firstOffsetX: CGFloat)
}

class NavigationViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    lazy var viewControllerList:[UIViewController] = {
        let sb = UIStoryboard(name: "MainScreen", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "MainStoryboard")
        vc1.restorationIdentifier = "MainScreen"
        let vc2 = sb.instantiateViewController(withIdentifier: "ProfileStoryboard")
        
        return [vc1, vc2]
    }()
    var pageViewScroll : UIScrollView?
    
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

        // Do any additional setup after loading the view.
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
//        print("\(String(describing: pendingViewControllers[0].restorationIdentifier))")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(!completed){
            return
        }
        if(previousViewControllers[0] == self.viewControllerList[0]){
            delegateAnimations?.swipeMainToProfile()
        } else if (previousViewControllers[0]) == self.viewControllerList[1]{
            delegateAnimations?.swipeProfileToMain()
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateAnimations?.moveAndScaleItems(with: scrollView.contentOffset)
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

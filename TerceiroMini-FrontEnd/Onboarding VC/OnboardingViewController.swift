//
//  OnboardingViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 21/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newOnboardViewController(identifier: "Onboarding1"),
                self.newOnboardViewController(identifier: "Onboarding2"),
                self.newOnboardViewController(identifier: "Onboarding3"),
                self.newOnboardViewController(identifier: "Onboarding4")]
    }()
    
    private func newOnboardViewController(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
        
}

// MARK: UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {

                let image = UIImage(named: "Oval")
                (view as! UIPageControl).backgroundColor = UIColor.clear
                (view as! UIPageControl).pageIndicatorTintColor = UIColor.init(patternImage: image!)
                (view as! UIPageControl).currentPageIndicatorTintColor = UIColor.darkGray
            }
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
}

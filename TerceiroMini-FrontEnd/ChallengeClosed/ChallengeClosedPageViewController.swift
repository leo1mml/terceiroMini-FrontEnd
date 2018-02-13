//
//  ChallengeClosedPageViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 13/02/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import UIKit

class ChallengeClosedPageViewController: UIPageViewController {

    var sender: UIViewController?
    var data: ([Photo], Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self as? UIPageViewControllerDataSource
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private(set) lazy var orderedViewControllers: [ChallengeClosedViewController] = {
        
        var views = [ChallengeClosedViewController]()
        
        for index in 0..<((data?.0)?.count)! {
            
            let viewController = newViewController(photo: ((data?.0)?[index])!, imageIndex: index)
            views.insert(viewController, at: index)
            
        }
        
        return views
    }()
    
    private func newViewController(photo: Photo, imageIndex: Int) -> ChallengeClosedViewController {
        let view =  UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "ChallengeClosed") as! ChallengeClosedViewController
        
        view.sender = self.sender
        view.data = photo
        view.imageIndex = imageIndex
        view.imagesCount = (self.data?.0.count)!
        
        return view
    }

}

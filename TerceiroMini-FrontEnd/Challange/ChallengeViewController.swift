//
//  ChallengeViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 14/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var numberOfPhotos: UILabel!
    @IBOutlet weak var ChallengeName: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
    var state = ChallengeState.open
    
    let startingGradientColor = UIColor(red:0, green:0, blue:0, alpha:0.7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.addChallengeGradientLayer(frame: view.bounds, colors: [startingGradientColor,.clear,.white])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resolveState(state: state)
        
        
    }
    
    func resolveState(state : ChallengeState){
        
        switch state {
        case .open:
            break
        case .votation:
            break
        case .finished:
            break
        default:
            break
        }
    }
    
    enum ChallengeState {
        case open
        case votation
        case finished
        
    }
    
}

extension UIView {
    
    func getConstraint(matchingIdentifier identifier: String) -> NSLayoutConstraint? {
        
        var constraint: NSLayoutConstraint?
        
        constraints.forEach {
            c in
            
            if c.identifier == identifier {
                 constraint = c
            }
        }
        
        return constraint
    }
}

extension UIImageView{
    func addChallengeGradientLayer(frame: CGRect, colors: [UIColor] ){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
}

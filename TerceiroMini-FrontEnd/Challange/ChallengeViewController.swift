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
    
    //Constraints that change size
    // - statusLabel
    @IBOutlet weak var statusLabelTimerConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabelWinnerContraint: NSLayoutConstraint!
    // - mainButton
    
    var state = ChallengeState.finished
    
    let startingGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:1.0)
    let middleGradientColor = UIColor(red:0.15, green:0.18, blue:0.19, alpha:0.4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.addChallengeGradientLayer(frame: view.bounds, colors: [startingGradientColor,middleGradientColor,.white])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resolveState(state: state)
        
        
    }
    
    func resolveState(state : ChallengeState){
        
        switch state {
        case .votation:
            break
        case .finished:
            changeStatusLabelContraint(open: false)
            //get winner and change main button
            break
        default:
            changeStatusLabelContraint(open: true)
            //get timer
            break
        }
    }
    
    func changeStatusLabelContraint(open: Bool){
        if(open){
            statusLabelWinnerContraint.priority = UILayoutPriority(rawValue: 750)
            statusLabelTimerConstraint.priority = UILayoutPriority(rawValue: 1000)
        }else{
            statusLabelWinnerContraint.priority = UILayoutPriority(rawValue: 1000)
            statusLabelTimerConstraint.priority = UILayoutPriority(rawValue: 750)
        }
    }
    
    enum ChallengeState {
        case open
        case votation
        case finished
        
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

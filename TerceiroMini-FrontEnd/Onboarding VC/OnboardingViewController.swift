//
//  OnboardingViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Augusto on 04/01/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    let images = ["imageOnboard1", "imageOnboard2", "imageOnboard3", "imageOnboard4"]
    
    let titles = ["Bem-vindo ao Clicks!",
                  "Participe!",
                  "Descubra!",
                  "Comece já!"]
    
    let descriptions = ["Somos uma rede social feita para \n pessoas que amam e pessoas \n que vão amar fotografar",
                        "Se desafie a fotografar temas variados, \n participe dos desafios, vote nos clicks \n favoritos, crie referências e divirta-se",
                        "Explore clicks de diferentes estilos e olhares \n feitos por fotógrafos do mundo inteiro e nos \n mostre também a sua visão de mundo",
                        "Não tenha vergonha, durante a competição \n todos clicks são enviados anonimamente, \n somente ao término os autores são revelados"]
    
    var page = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        finishButton.setTitle("PULAR!", for: .normal)
        self.scrollView.delegate = self
        image.image = UIImage(named: images[page])
        self.initializeScroll(index: page)
    }
    
    @IBAction func finishOnboarding(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "boarded")
        performSegue(withIdentifier: "onboardingSegue", sender: self)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func animate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.image.alpha = 0
        }, completion: { finished in
            
            self.image.image = UIImage(named: self.images[self.page])
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self.image.alpha = 1
            }, completion: { finished in })
        })
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if (page - 1) >= 0 {
                    page = page - 1
                    scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x - self.scrollView.frame.size.width, y: 0), animated: true)
                    self.animate()
                }
                break
            case UISwipeGestureRecognizerDirection.left:
                if (page + 1) < 4 {
                    page = page + 1
                    scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x + self.scrollView.frame.size.width, y: 0), animated: true)
                    self.animate()
                }
                break
            default:
                break
            }
            if(page != 3){
                finishButton.setTitle("PULAR!", for: .normal)
            }else{
                finishButton.setTitle("VAMOS LÁ!", for: .normal)
            }
            
//             finishButton.isHidden = !(page == 3)

        }

    }
    
}

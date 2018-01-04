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
    
    let titles = ["Bem-vindo ao Clicks!",
                  "Participe!",
                  "Descubra!",
                  "Comece já!"]
    
    let descriptions = ["Somos uma rede social feita para pessoas que amam e pessoas que vão amar fotografar",
                        "Se desafie a fotografar temas variados, participe dos desafios, vote nos clicks favoritos, crie referências e divirta-se",
                        "Explore clicks de diferentes estilos e olhares feitos por fotógrafos do mundo inteiro e nos mostre também a sua visão de mundo",
                        "Não tenha vergonha, durante a competição todos clicks são enviados anonimamente, somente ao término os autores são revelados"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.initializeScroll(index: 0)
    }
    
}

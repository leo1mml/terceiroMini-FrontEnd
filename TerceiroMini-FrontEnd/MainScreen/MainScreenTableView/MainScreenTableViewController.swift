//
//  MainScreenTableViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class MainScreenTableViewController: UITableViewController {
    
    @IBOutlet weak var challengesCell: OpenChallengesTableViewCell!
    
    var delegateNavigateInApp : NavigateInAppProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TableHeader()
        if(section == 0){
            header.sectionTitle.text = ""
            header.seeMoreButton.isHidden = true
        }else if(section == 1) {
            header.sectionTitle.text = "ÚLTIMOS VENCEDORES"
            header.seeMoreButton.isHidden = false
            header.seeMoreButton.addTarget(self, action: #selector(goToAllPastChallenges), for: .touchUpInside)
            header.seeMoreButton.setTitle("Ver todos", for: .normal)
        }else if(section == 2) {
            header.sectionTitle.text = "PRÓXIMOS"
            header.seeMoreButton.isHidden = true
        }
        header.backgroundColor = .white
        
        return header
    }
    
    @objc func goToAllPastChallenges() {
//        self.performSegue(withIdentifier: "goToSeeAll", sender: self)
        delegateNavigateInApp?.goToSeeAll()
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }


}

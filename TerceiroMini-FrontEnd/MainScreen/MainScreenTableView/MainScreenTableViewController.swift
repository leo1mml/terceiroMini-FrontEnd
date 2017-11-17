//
//  MainScreenTableViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 16/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class MainScreenTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TableHeader()
        if(section == 0){
            header.sectionTitle.text = "ABERTOS"
            header.seeMoreButton.isHidden = true
        }else if(section == 1) {
            header.sectionTitle.text = "ÚLTIMOS VENCEDORES"
            header.seeMoreButton.isHidden = false
            header.seeMoreButton.setTitle("Ver todos", for: .normal)
        }else if(section == 2) {
            header.sectionTitle.text = "PRÓXIMOS"
            header.seeMoreButton.isHidden = true
        }
        header.backgroundColor = .white
        
        return header
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

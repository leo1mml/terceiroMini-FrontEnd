//
//  ConfigurationTableViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 12/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ConfigurationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ConfigHeader()
        switch section {
        case 0:
            header.titleLabel.text = "CONTA"
            break
        case 1:
            header.titleLabel.text = "SUPORTE"
            break
        case 2:
            header.titleLabel.text = "SOBRE"
            break
        default:
            header.titleLabel.text = ""
            break
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = ConfigFooter()
        if(section == 2){
            footer.backgroundColor = .white
        }
        return footer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 1 && indexPath.section == 2){
            if let url = URL(string: "http://photoappchallenge.herokuapp.com/privacy-politic.html") {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }

}

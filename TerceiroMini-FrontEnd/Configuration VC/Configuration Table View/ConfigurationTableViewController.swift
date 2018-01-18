//
//  ConfigurationTableViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 12/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import MessageUI

class ConfigurationTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    var loginProtocol : LoginCallerPortocol?

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
        case 1:
            header.titleLabel.text = "CONTA"
            break
        case 2:
            header.titleLabel.text = "SUPORTE"
            break
        case 3:
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
        if(section == 3){
            footer.backgroundColor = .white
        }
        return footer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0 && indexPath.section == 3){
            if let url = URL(string: "http://photoappchallenge.herokuapp.com/privacy-politic.html") {
                UIApplication.shared.open(url, options: [:])
            }
        }
        if(indexPath.row == 1 && indexPath.section == 3){
            if let url = URL(string: "http://photoappchallenge.herokuapp.com/terms-of-use.html") {
                UIApplication.shared.open(url, options: [:])
            }
        }
        if(indexPath.row == 1 && indexPath.section == 2){
            composeMail()
        }
        if(indexPath.row == 0 && indexPath.section == 4){
            //mostra alerta para sair
            createLogOutAlert(title: "Logout", message: "Deseja sair desta conta?")
        }
    }
    
    func createLogOutAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Sair", style: .default, handler: { (action) in
                UserDefaults.standard.set(nil, forKey: "token")
                self.loginProtocol?.loginFinishedSuccessfully()
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func composeMail() {
        let mailCompose = self.configuredMailCompose()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailCompose, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailCompose() -> MFMailComposeViewController{
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        mailCompose.setToRecipients(["Clicksmail.contact@gmail.com"])
        mailCompose.setSubject("Clicks! - Contact Us")
        
        return mailCompose
    }
    
    func showSendMailErrorAlert(){
        let alert = UIAlertController(title: "Erro de e-mail", message: "Não foi possivel enviar o e-mail", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0 || section == 4){
            return CGFloat(0)
        }
        return CGFloat(53)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 4 || section == 0){
            return CGFloat(0)
        }
        return CGFloat(1)
    }
}

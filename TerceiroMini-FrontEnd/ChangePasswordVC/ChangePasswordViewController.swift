//
//  ChangePasswordViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 30/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveNewPassword(_ sender: Any) {
        
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
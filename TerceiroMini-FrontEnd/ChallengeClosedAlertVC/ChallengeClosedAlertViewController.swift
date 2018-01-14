//
//  ChallengeClosedAlertViewController.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 14/01/2018.
//  Copyright © 2018 BEPID. All rights reserved.
//

import UIKit

class ChallengeClosedAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

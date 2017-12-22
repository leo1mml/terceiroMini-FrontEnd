//
//  LoginPresentationPresenterImpl.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 27/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import FacebookLogin
import FBSDKLoginKit

class LoginPresentationPresenterImpl: LoginPresentationPresenter {
    
    var view: LoginPresentationView
    
    init(loginPresentationViewImpl view: LoginPresentationView) {
        self.view = view
    }
    
    func exitButtonClicked() {
        view.exitLoginPresentation()
    }
    
    func emailLoginButtonClicked() {
        view.goToLogin()
    }
    
    func facebookLoginButtonClicked() {
        
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
                self.showParameters()
            }
        }
    }
    
    func showParameters() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"name, email"]).start(completionHandler: {
            (connection, result, err) in
            
            if err != nil {
                print(err as Any)
                return
            }

            let itens = result as! NSDictionary
            
            let id = itens.value(forKey: "id") as! String
            let profileImageUrl = "http://graph.facebook.com/\(id)/picture?type=large"
            let name = itens.value(forKey: "name") as! String
            let email = itens.value(forKey: "email") as! String
            
            NetworkManager.createLoginFacebook(name: name, email: email, profileImgUrl: profileImageUrl, completion: { (user, token, err) in
                guard err == nil else {
                    
                    return
                }
                
                UserDefaults.standard.set(token, forKey: "token")
                let encodedUser = NSKeyedArchiver.archivedData(withRootObject: user!)
                UserDefaults.standard.set(encodedUser, forKey: "logedUser")
                UserDefaults.standard.synchronize()
                self.view.goToApp()
            })

        })
    }
    
    func createAccountButtonClicked() {
        view.goToRegister()
    }
    
}

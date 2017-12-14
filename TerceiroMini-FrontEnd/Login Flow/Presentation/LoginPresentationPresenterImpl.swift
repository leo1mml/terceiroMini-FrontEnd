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
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"]).start(completionHandler: {
            (connection, result, err) in
            
            if err != nil {
                print(err as Any)
                return
            }
            print(result)
            let itens = result as! NSDictionary
            
            print("\(itens.value(forKey: "name") as!String)")
            print("\(itens.value(forKey: "email") as! String)")
            print("\(itens.value(forKey: "gender") as! String)")
            //            let url = NetworkConnection.database + "users/"
            //
            //
            //            let user = User()
            //
            //            user.name = itens.value(forKey: "name") as!String
            //            user.email = itens.value(forKey: "email") as! String
            //            user.gender = itens.value(forKey: "gender") as! String
            //            user.password = "123456"
            //            user.pins = ["LEO#2016"]
            //
            //
            //            Singleton.sharedInstance.user = user
            //
            //            self.connection.post(URL: "http://localhost:3000/users/", user: user)
            //            //            self.connection.post(URL: url, user: user)
            //
            //            self.performSegue(withIdentifier: "SchoolAuthentication", sender: Any?.self)
        })
    }
    
    func createAccountButtonClicked() {
        view.goToRegister()
    }
    
}

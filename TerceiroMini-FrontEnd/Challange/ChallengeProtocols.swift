//
//  ChallengeProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 20/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

protocol ChallengeView{
    func changeMainPhoto()
    func changeScreen()
    func showTimer()
    func getPhoto()
    func takePhoto()
    
    
}

protocol ChallengePresenter{
    func sendPhoto()
    func getChallengeTimer()
}

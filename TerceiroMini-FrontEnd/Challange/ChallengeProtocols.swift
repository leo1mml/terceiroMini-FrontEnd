//
//  ChallengeProtocols.swift
//  TerceiroMini-FrontEnd
//
//  Created by Pedro Oliveira on 20/11/17.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation
import UIKit

protocol ChallengeView{
    func changeMainPhoto()
    func changeScreen()
    func showTimer()
    func getPhoto()
    func takePhoto()
    func showPhotoMenu()
}

protocol ChallengePresenter{
    func sendPhotoToCloudinary(infoImage: UIImage)
    func getChallengeTimer()
    func mainButtonClicked()
}

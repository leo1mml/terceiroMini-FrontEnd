//
//  WebResources.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 24/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

/**
 
 This class holds the informations about the web service that is being used by the app.
 */
class R {
    
    private init() {}
    
    /// The domain of the application web service.
    static let urlDomain = "http://photoappchallenge.herokuapp.com"
    /// The path to access the users data in the web service.
    static let usersDomain = "\(urlDomain)/users"
    /// The path to access the photos data in the web service.
    static let photosDomain = "\(urlDomain)/photos"
    /// The path to access the challenges data in the web service.
    static let challengesDomain = "\(urlDomain)/challenges"
}

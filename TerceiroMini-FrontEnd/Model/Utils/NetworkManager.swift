//
//  NetworkManager.swift
//  TerceiroMini-FrontEnd
//
//  Created by Gabriel Reynoso on 24/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private init() {}
    
    // MARK: - User methods
    
    class func getAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        UserNet.getAll(completion: completion)
    }
    
    class func addUser(_ user: User, password: String, completion: @escaping (User?, String?, Error?) -> Void) {
        UserNet.add(user: user, password: password, completion: completion)
    }
    
    class func getUser(byToken token: String, completion: @escaping (User?, Error?) -> Void) {
        UserNet.get(byToken: token, completion: completion)
    }
    
    class func getUser(byId id: String, completion: @escaping (User?, Error?) -> Void) {
        UserNet.get(byId: id, completion: completion)
    }
    
    class func getLastWinners(completion: @escaping (_ lastWinners: [User]?, _ error: Error?) -> Void) {
        UserNet.getLastWinners(completion: completion)
    }
    
    class func createLogin(email: String, username: String?, password: String, completion: @escaping (Bool) -> Void) {
        UserNet.createLogin(username: username, email: email, password: password, completion: completion)
    }
    
    class func deleteUser(byId id: String, completion: @escaping (Bool) -> Void) {
        UserNet.delete(byId: id, completion: completion)
    }
    
    // MARK: - Photo methods
    
    class func getAllPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
        PhotoNet.getAll(completion: completion)
    }
    
    class func addPhoto(_ photo: Photo, completion: @escaping (Photo?, Error?) -> Void) {
        PhotoNet.add(photo: photo, completion: completion)
    }
    
    class func getPhotos(byToken token: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        PhotoNet.get(byToken: token, completion: completion)
    }
    
    class func getPhotos(byChallengeId id: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        PhotoNet.get(byChallengeId: id, completion: completion)
    }
    
    class func getPhoto(byId id: String, completion: @escaping (Photo?, Error?) -> Void) {
        PhotoNet.get(byId: id, completion: completion)
    }
    
    class func deletePhoto(byId id: String, completion: @escaping (Photo?, Error?) -> Void) {
        PhotoNet.delete(byId: id, completion: completion)
    }
    
    class func getUserPhotos(byUserId id: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        PhotoNet.get(byUserId: id, completion: completion)
    }
    
    // MARK: - Challenge methods
    
    class func getAllChallenges(completion: @escaping ([Challenge]?, Error?) -> Void) {
        ChallengeNet.getAll(completion: completion)
    }
    
    class func getOpenChallenges(completion: @escaping (_ c: [Challenge]?, _ e: Error?) -> Void) {
        ChallengeNet.getOpenChallenges(completion: completion)
    }
    
    class func getLastChallenges(completion: @escaping (_ c: [Challenge]?, _ e: Error?) -> Void) {
        ChallengeNet.getLastChallenges(completion: completion)
    }
    
    class func getComingSoonChallenges(completion: @escaping (_ c: [Challenge]?, _ e: Error?) -> Void) {
        ChallengeNet.getComingSoonChallenges(completion: completion)
    }
    class func getChallengeById(id: String, completion: @escaping (_ c: Challenge?, _ e: Error?) -> Void) {
        ChallengeNet.getById(id: id, completion: completion)
    }

}

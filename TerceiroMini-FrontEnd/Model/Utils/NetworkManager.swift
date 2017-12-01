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
    
    func getAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        UserNet.getAll(completion: completion)
    }
    
    func addUser(_ user: User, password: String, completion: @escaping (User?, String?, Error?) -> Void) {
        UserNet.add(user: user, password: password, completion: completion)
    }
    
    func getUser(byToken token: String, completion: @escaping (User?, Error?) -> Void) {
        UserNet.get(byToken: token, completion: completion)
    }
    
    func getUser(byId id: String, completion: @escaping (User?, Error?) -> Void) {
        UserNet.get(byId: id, completion: completion)
    }
    
    func createLogin(email: String, username: String, password: String, completion: @escaping (Bool) -> Void) {
        UserNet.createLogin(username: username, email: email, password: password, completion: completion)
    }
    
    func deleteUser(byId id: String, completion: @escaping (Bool) -> Void) {
        UserNet.delete(byId: id, completion: completion)
    }
    
    // MARK: - Photo methods
    
    func getAllPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
        PhotoNet.getAll(completion: completion)
    }
    
    func addPhoto(_ photo: Photo, completion: @escaping (Photo?, Error?) -> Void) {
        PhotoNet.add(photo: photo, completion: completion)
    }
    
    func getPhotos(byToken token: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        PhotoNet.get(byToken: token, completion: completion)
    }
    
    func getPhotos(byChallengeId id: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        PhotoNet.get(byChallengeId: id, completion: completion)
    }
    
    func getPhoto(byId id: String, completion: @escaping (Photo?, Error?) -> Void) {
        PhotoNet.get(byId: id, completion: completion)
    }
    
    func deletePhoto(byId id: String, completion: @escaping (Photo?, Error?) -> Void) {
        PhotoNet.delete(byId: id, completion: completion)
    }
    
    // MARK: - Challenge methods
    
    func getAllChallenges(completion: @escaping ([Challenge]?, Error?) -> Void) {
        ChallengeNet.getAll(completion: completion)
    }

}

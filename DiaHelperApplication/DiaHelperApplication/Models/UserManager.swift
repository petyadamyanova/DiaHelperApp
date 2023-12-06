//
//  UserManager.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.12.23.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private var users: [User] = []
    
    private init() {}
    
    func getCurrentUser() -> User? {
        return users.first
    }
    
    func saveUser(_ user: User) {
        users.append(user)
    }
}


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
    
    func addMeal(_ meal: Meal) {
        if var user = UserManager.shared.getCurrentUser(){
            user.meals.append(meal)
        }else{
            print("There is no current user.")
        }
    }
    
    func getAllMeals() -> [Meal] {
        if var user = UserManager.shared.getCurrentUser(){
            return user.meals
        }else{
            print("There is no current user.")
        }
        
        return []
    }
}


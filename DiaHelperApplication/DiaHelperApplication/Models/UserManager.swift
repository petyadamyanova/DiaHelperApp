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
    private var currentGlucose: String?
    
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
    
    func setCurrentGlucose(_ glucose: String){
        currentGlucose = glucose
    }
    
    func getCurrentGlucose() -> String{
        return currentGlucose ?? ""
    }
    
    func getAllMeals() -> [Meal] {
        if let user = UserManager.shared.getCurrentUser(){
            return user.meals
        }else{
            print("There is no current user.")
        }
        
        return []
    }
}


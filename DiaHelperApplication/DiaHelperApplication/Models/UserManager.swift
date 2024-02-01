//
//  UserManager.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.12.23.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private var currentUser: User?
    private var currentGlucose: String?
    private var currentUserId: String?
    private var meals: [Meal] = []
    private var glucometerBloodSugarTests: [GlucometerBloodSugarTest] = []
    
    private init() {}
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    func getCurrentUserId() -> String {
        return currentUserId ?? ""
    }
    
    func setCurrentUserId(id: String){
        currentUserId = id
    }
    
    func saveUser(_ user: User) {
        currentUser = user
    }
    
    func addMeal(_ meal: Meal) {
        meals.append(meal)
        /*if var user = UserManager.shared.getCurrentUser(){
            user.meals.append(meal)
        }else{
            print("There is no current user.")
        }*/
    }
    
    func addGlucometerBloodSugarTest(_ test: GlucometerBloodSugarTest){
        glucometerBloodSugarTests.append(test)
    }
    
    func getAllGlucometerBloodSugarTests() -> [GlucometerBloodSugarTest] {
        return glucometerBloodSugarTests
    }
    
    func setCurrentGlucose(_ glucose: String){
        currentGlucose = glucose
    }
    
    func getCurrentGlucose() -> String{
        return currentGlucose ?? ""
    }
    
    func getAllMeals() -> [Meal] {
        /*if let user = UserManager.shared.getCurrentUser(){
            return user.meals
        }else{
            print("There is no current user.")
        }*/
        
        return meals
    }
}


//
//  Meal.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.12.23.
//

import Foundation

struct Meal: Codable {
    var timestamp: Date
    var bloodSugar: Double
    var insulinDose: Double
    var carbsIntake: Double
    var foodType: FoodType
}

enum FoodType: String, Codable, CaseIterable  {
    case fast
    case medium
    case slow
    case other
}

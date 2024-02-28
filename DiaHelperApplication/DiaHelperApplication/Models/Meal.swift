//
//  Meal.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.12.23.
//

import Foundation

struct Meal: Codable {
    var id: String
    var timestamp: String
    var bloodSugar: Double
    var insulinDose: Double
    var carbsIntake: Double
    var foodType: FoodType
    
    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case bloodSugar
        case insulinDose
        case carbsIntake
        case foodType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)

        bloodSugar = try container.decode(Double.self, forKey: .bloodSugar)
        insulinDose = try container.decode(Double.self, forKey: .insulinDose)
        carbsIntake = try container.decode(Double.self, forKey: .carbsIntake)
        foodType = try container.decode(FoodType.self, forKey: .foodType)
        timestamp = try container.decode(String.self, forKey: .timestamp)
    }
    
    init(id: String, timestamp: String, bloodSugar: Double, insulinDose: Double, carbsIntake: Double, foodType: FoodType) {
        self.timestamp = timestamp
        self.bloodSugar = bloodSugar
        self.insulinDose = insulinDose
        self.carbsIntake = carbsIntake
        self.foodType = foodType
        self.id = id
    }
}


enum FoodType: String, Codable, CaseIterable  {
    case fast
    case medium
    case slow
    case other
}



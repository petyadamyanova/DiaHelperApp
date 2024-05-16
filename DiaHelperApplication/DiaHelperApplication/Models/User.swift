//
//  user.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 26.11.23.
//

import Foundation

struct User: Codable {
    var email: String
    var username: String
    var nightscout: String
    var birtDate: String
    var yearOfDiagnosis: String
    var pumpModel: PumpModel
    var sensorModel: SensorModel
    var insulinType: InsulinType
    var meals: [Meal] = []
    var glucometerBloodSugarTests: [GlucometerBloodSugarTest] = []
}

enum PumpModel: String, Codable, CaseIterable  {
    case Medtronic
    case Omnipod
    case Danna
    case Upso
    case Other
    case None
}

enum SensorModel: String, Codable, CaseIterable  {
    case Dexcom
    case Libre
    case Other
    case None
}

enum InsulinType: String, Codable, CaseIterable {
    case Novolog
    case Humalog
    case Apidra
    case Fiasp
    case Lyumjev
    case Other
}

struct LoginResponse: Codable {
    var token: String
    var user: UserResponse
}

struct UserResponse: Codable {
    var id: String
    var username: String
    var email: String
    var nightscout: String
    var birtDate: String
    var yearOfDiagnosis: String
    var pumpModel: String
    var sensorModel: String
    var insulinType: String
}

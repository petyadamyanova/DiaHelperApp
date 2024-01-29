//
//  user.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 26.11.23.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var username: String
    var password: String
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

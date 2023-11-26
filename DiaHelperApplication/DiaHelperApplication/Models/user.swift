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
    var nigscout: String
    var birtDate: String
    var yearOfDiagnosis: String
    var pumpModel: PumpModel
    var sensorModel: SensorModel
}

enum PumpModel: String, Codable {
    case Medtronic
    case Omnipod
    case Danna
    case Upso
    case Other
    case None
}

enum SensorModel: String, Codable {
    case Dexcom
    case Libre
    case Other
    case None
    
}

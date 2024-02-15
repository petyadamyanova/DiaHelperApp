//
//  StartTimes.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 15.02.24.
//

import Foundation

struct StartTimes: Codable {
    var sensorStartDateTime: String
    var pumpStartDateTime: String
    var insulinCanulaStartDateTime: String
    var glucometerCanulaStartDateTime: String

    /*enum CodingKeys: String, CodingKey {
        case id
        case sensorStartDateTime
        case pumpStartDateTime
        case insulinCanulaStartDateTime
        case glucometerCanulaStartDateTime
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        sensorStartDateTime = try container.decode(String.self, forKey: .sensorStartDateTime)
        pumpStartDateTime = try container.decode(String.self, forKey: .pumpStartDateTime)
        insulinCanulaStartDateTime = try container.decode(String.self, forKey: .insulinCanulaStartDateTime)
        glucometerCanulaStartDateTime = try container.decode(String.self, forKey: .glucometerCanulaStartDateTime)
    }*/
    
    init(sensorStartDateTime: String, pumpStartDateTime: String, insulinCanulaStartDateTime: String, glucometerCanulaStartDateTime: String) {
        self.sensorStartDateTime = sensorStartDateTime
        self.pumpStartDateTime = pumpStartDateTime
        self.insulinCanulaStartDateTime = insulinCanulaStartDateTime
        self.glucometerCanulaStartDateTime = glucometerCanulaStartDateTime
    }
}

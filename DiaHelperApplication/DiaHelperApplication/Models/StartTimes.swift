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
    
    init(sensorStartDateTime: String, pumpStartDateTime: String, insulinCanulaStartDateTime: String, glucometerCanulaStartDateTime: String) {
        self.sensorStartDateTime = sensorStartDateTime
        self.pumpStartDateTime = pumpStartDateTime
        self.insulinCanulaStartDateTime = insulinCanulaStartDateTime
        self.glucometerCanulaStartDateTime = glucometerCanulaStartDateTime
    }
}

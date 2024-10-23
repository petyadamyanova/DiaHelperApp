//
//  GlucometerBloodSugarTest.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 17.12.23.
//

import Foundation

struct GlucometerBloodSugarTest: Codable, Identifiable {
    var timestamp: String
    var bloodSugar: Double
    
    var id: String { timestamp }
}

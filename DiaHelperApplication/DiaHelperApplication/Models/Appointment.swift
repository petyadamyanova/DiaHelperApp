//
//  Appointment.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 31.03.24.
//

import Foundation

struct Appointment: Codable {
    var label: String
    var doctor: String
    var date: String
    var place: String
}

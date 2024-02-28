//
//  BirthDateValidator.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 30.11.23.
//

import Foundation

class BirthDateValidator {
    func isValid(_ birthDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let date = dateFormatter.date(from: birthDate) else {
            return false  // Invalid birthDate format
        }

        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())

        let birthYear = calendar.component(.year, from: date)

        return birthYear <= currentYear
    }
}

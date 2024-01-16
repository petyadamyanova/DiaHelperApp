//
//  YearOfDiagnosisValidator.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 30.11.23.
//

import Foundation

class YearOfDiagnosisValidator {
    func isValid(_ yearOfDiagnosis: String, _ birthDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        guard let date = dateFormatter.date(from: birthDate) else {
            return false  // Invalid birthDate format
        }

        let calendar = Calendar.current
        let birthYear = calendar.component(.year, from: date)

        guard let year = Int(yearOfDiagnosis), year >= birthYear else {
            return false
        }

        return true
    }
}

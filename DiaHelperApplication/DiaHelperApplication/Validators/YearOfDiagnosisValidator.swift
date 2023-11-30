//
//  YearOfDiagnosisValidator.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 30.11.23.
//

import Foundation

class YearOfDiagnosisValidator {
    func isValid(_ yearOfDiagnosis: String) -> Bool {
        guard let year = Int(yearOfDiagnosis), year >= 1900 else {
            return false
        }
        return true
    }
}

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
        return dateFormatter.date(from: birthDate) != nil
    }
}

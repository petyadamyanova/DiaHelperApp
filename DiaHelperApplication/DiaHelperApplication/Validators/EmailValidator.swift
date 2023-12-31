//
//  EmailValidator.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 12.11.23.
//

import Foundation

class EmailValidator {
    func isValid(_ email: String) -> Bool {
        let emailRegex = "^[a-zA-Z0-9._%]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

//
//  UsernameValidator.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 12.11.23.
//

import Foundation

class UsernameValidator {
    func isValid(_ username: String) -> Bool {
        username.count >= 3
    }
}

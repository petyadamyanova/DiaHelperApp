//
//  PasswordValidator.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 12.11.23.
//

import Foundation

class PasswordValidator {
    func isValid(_ password: String) -> Bool {
        return isValidCount(password) && containsUppercaseLetter(password) &&
               containsLowercaseLetter(password) && containsDigit(password) &&
               containsSpecialCharacter(password)
    }
    
    func isValidCount(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    func containsUppercaseLetter(_ password: String) -> Bool {
        return password.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    func containsLowercaseLetter(_ password: String) -> Bool {
        return password.rangeOfCharacter(from: .lowercaseLetters) != nil
    }
    
    func containsDigit(_ password: String) -> Bool {
        return password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    func containsSpecialCharacter(_ password: String) -> Bool {
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>?/~`")
        return password.rangeOfCharacter(from: specialCharacterSet) != nil
    }
    
}

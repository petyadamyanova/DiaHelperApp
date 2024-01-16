//
//  PasswordValidatorTests.swift
//  DiaHelperApplicationTests
//
//  Created by Petya Damyanova on 30.11.23.
//

import XCTest
@testable import DiaHelperApplication

final class PasswordValidatorTests: XCTestCase {
    let passwordValidator = PasswordValidator()
    
    func testPasswordValidationIsValid() {
        let passwordTest = "Password1*"
        
        let passwordValidationResult = passwordValidator.isValid(passwordTest)
        
        XCTAssertTrue(passwordValidationResult, "Password \(passwordTest) is not valid!")
    }
    
    func testPasswordValidationIsNotValid() {
        let passwordTest = "11111111"
        
        let passwordValidationResult = passwordValidator.isValid(passwordTest)
        
        XCTAssertFalse(passwordValidationResult, "Password \(passwordTest) is valid!")
    }
    
    func testPasswordValidationIsNotValid2() {
        let passwordTest = "password1*"
        
        let passwordValidationResult = passwordValidator.isValid(passwordTest)
        
        XCTAssertFalse(passwordValidationResult, "Password \(passwordTest) is valid!")
    }
    
    func testPasswordValidationIsNotValid3() {
        let passwordTest = "Password1"
        
        let passwordValidationResult = passwordValidator.isValid(passwordTest)
        
        XCTAssertFalse(passwordValidationResult, "Password \(passwordTest) is valid!")
    }
    
    func testPasswordValidationIsNotValid4() {
        let passwordTest = "Password*"
        
        let passwordValidationResult = passwordValidator.isValid(passwordTest)
        
        XCTAssertFalse(passwordValidationResult, "Password \(passwordTest) is valid!")
    }
    
}

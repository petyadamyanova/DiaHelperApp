//
//  EmailValidatorTests.swift
//  DiaHelperApplicationTests
//
//  Created by Petya Damyanova on 30.11.23.
//

import XCTest
@testable import DiaHelperApplication

final class EmailValidatorTests: XCTestCase {
    let emailValidator = EmailValidator()
    
    func testEmailValidationIsValid() {
        let emailTest = "test@example.com"
        
        let emailValidationResult = emailValidator.isValid(emailTest)
        
        XCTAssertTrue(emailValidationResult, "Email \(emailTest) was not valid!")
    }
    
    func testEmailValidationIsNotValid() {
        let emailTest = "invalid_email"
        
        let emailValidationResult = emailValidator.isValid(emailTest)
        
        XCTAssertFalse(emailValidationResult, "Email \(emailTest) was valid!")
    }
}

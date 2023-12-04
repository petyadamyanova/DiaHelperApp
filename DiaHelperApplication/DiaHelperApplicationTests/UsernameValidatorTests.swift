//
//  UsernameValidatorTests].swift
//  DiaHelperApplicationTests
//
//  Created by Petya Damyanova on 4.12.23.
//

import Foundation

import XCTest
@testable import DiaHelperApplication

final class UsernameValidatorTests: XCTestCase {
    let usernameValidator = UsernameValidator()
    
    func testUsernameValidationIsValid() {
        let usernameTest = "Petya"
        
        let usernameValidationResult = usernameValidator.isValid(usernameTest)
        
        XCTAssertTrue(usernameValidationResult, "Username \(usernameTest) is not valid!")
    }
    
    func testUsernameValidationIsNotValid() {
        let usernameTest = "P"
        
        let usernameValidationResult = usernameValidator.isValid(usernameTest)
        
        XCTAssertFalse(usernameValidationResult, "Username \(usernameTest) is valid!")
    }
    
    func testUsernameValidationIsNotValid2() {
        let usernameTest = "Pe"
        
        let usernameValidationResult = usernameValidator.isValid(usernameTest)
        
        XCTAssertFalse(usernameValidationResult, "Username \(usernameTest) is valid!")
    }
}

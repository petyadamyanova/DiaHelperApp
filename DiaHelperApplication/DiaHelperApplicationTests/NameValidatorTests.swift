//
//  NameValidatorTests.swift
//  DiaHelperApplicationTests
//
//  Created by Petya Damyanova on 4.12.23.
//

import Foundation

import XCTest
@testable import DiaHelperApplication

final class NameValidatorTests: XCTestCase {
    let nameValidator = NameValidator()
    
    func testNameValidationIsValid() {
        let nameTest = "Petya"
        
        let nameValidationResult = nameValidator.isValid(nameTest)
        
        XCTAssertTrue(nameValidationResult, "Name \(nameTest) is not valid!")
    }
    
    func testUsernameValidationIsNotValid() {
        let nameTest = ""
        
        let nameValidationResult = nameValidator.isValid(nameTest)
        
        XCTAssertFalse(nameValidationResult, "Name \(nameTest) is valid!")
    }
}

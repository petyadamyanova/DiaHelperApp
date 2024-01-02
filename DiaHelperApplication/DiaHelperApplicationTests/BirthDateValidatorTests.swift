//
//  BirthDateValidatorTests.swift
//  DiaHelperApplicationTests
//
//  Created by Petya Damyanova on 4.12.23.
//

import Foundation

import XCTest
@testable import DiaHelperApplication

final class BirthDateValidatorTests: XCTestCase {
    let birthDateValidator = BirthDateValidator()
    
    func testBirthDareValidationIsValid() {
        let birthDateTest = "09/02/2005"
        
        let birthDateValidationResult = birthDateValidator.isValid(birthDateTest)
        
        XCTAssertTrue(birthDateValidationResult, "BirthDate \(birthDateTest) is not valid!")
    }
    
    func testBirthDareValidationIsNotValid() {
        let birthDateTest = "09/31/2000"
        
        let birthDateValidationResult = birthDateValidator.isValid(birthDateTest)
        
        XCTAssertFalse(birthDateValidationResult, "BirthDate \(birthDateTest) is valid!")
    }
    
    func testBirthDareValidationIsNotValid2() {
        let birthDateTest = "09/02/-922005"
        
        let birthDateValidationResult = birthDateValidator.isValid(birthDateTest)
        
        XCTAssertFalse(birthDateValidationResult, "BirthDate \(birthDateTest) is valid!")
    }
    
    func testBirthDareValidationIsNotValid3() {
        let birthDateTest = "09/2005"
        
        let birthDateValidationResult = birthDateValidator.isValid(birthDateTest)
        
        XCTAssertFalse(birthDateValidationResult, "BirthDate \(birthDateTest) is valid!")
    }
    
    func testBirthDareValidationIsNotValid4() {
        let birthDateTest = "36/02/2005"
        
        let birthDateValidationResult = birthDateValidator.isValid(birthDateTest)
        
        XCTAssertFalse(birthDateValidationResult, "BirthDate \(birthDateTest) is not valid!")
    }
    
}

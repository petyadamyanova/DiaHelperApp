//
//  YearOfDiagnosisValidatorTests.swift
//  DiaHelperApplicationTests
//
//  Created by Petya Damyanova on 4.12.23.
//

import Foundation

import XCTest
@testable import DiaHelperApplication

final class YearOfDiagnosisValidatorTests: XCTestCase {
    let yearOfDiagnosisValidator = YearOfDiagnosisValidator()
    
    func testYearOfDiagnosisValidationIsValid() {
        let yearTest = "2006"
        let birthDateTest = "09/02/2006"
        
        let yearOFDiagnosisValidationResult = yearOfDiagnosisValidator.isValid(yearTest, birthDateTest)
        
        XCTAssertTrue(yearOFDiagnosisValidationResult, "Year \(yearTest) is not valid!")
    }
    
    func testYearOfDiagnosisValidationIsValid2() {
        let yearTest = "2008"
        let birthDateTest = "09/02/2006"
        
        let yearOFDiagnosisValidationResult = yearOfDiagnosisValidator.isValid(yearTest, birthDateTest)
        
        XCTAssertTrue(yearOFDiagnosisValidationResult, "Year \(yearTest) is not valid!")
    }
    
    func testYearOfDiagnosisValidationIsNotValid() {
        let yearTest = "2004"
        let birtDateTest = "09/02/2006"
        
        let yearOFDiagnosisValidationResult = yearOfDiagnosisValidator.isValid(yearTest, birtDateTest)
        
        XCTAssertFalse(yearOFDiagnosisValidationResult, "Year \(yearTest) is valid!")
    }
    
    func testYearOfDiagnosisValidationIsNotValid2() {
        let yearTest = "2006"
        let birthDateTest = "0999/89"
        
        let yearOFDiagnosisValidationResult = yearOfDiagnosisValidator.isValid(yearTest, birthDateTest)
        
        XCTAssertFalse(yearOFDiagnosisValidationResult, "Birtdate \(birthDateTest) is not valid!")
    }
    
}

//
//  LoginViewModelTests.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 10.11.24.
//


class LoginUserAPITest: LoginInterface {
    var scenario: Scenario = .success
    
    enum Scenario {
        case success
        case invalidEmailOrPassword
    }
    
    func loginUser(email: String, password: String) async throws -> User {
        switch scenario {
        case .success:
            return User(
                email: email,
                username: "testUser",
                nightscout: "",
                birtDate: "2000-01-01",
                yearOfDiagnosis: "2015",
                pumpModel: .Other,
                sensorModel: .Other,
                insulinType: .Other
            )
        case .invalidEmailOrPassword:
            throw LoginError.invalidEmailOrPassword
        }
    }
}

import XCTest
@testable import DiaHelperApplication

final class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockAPI: LoginUserAPITest!
       
    override func setUp() {
       super.setUp()
       mockAPI = LoginUserAPITest()
       viewModel = LoginViewModel(api: mockAPI)
    }
    
    func testLoginSuccess() async {
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        mockAPI.scenario = .success
        let expectation = XCTestExpectation(description: "Login success")
        
        do {
            try await viewModel.login()
            expectation.fulfill()
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testLoginFailureInvalidEmailOrPassword() async {
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        mockAPI.scenario = .invalidEmailOrPassword
        let expectation = XCTestExpectation(description: "Login failed with invalid email or password error")
        
        do {
            try await viewModel.login()
            XCTFail("Expected failure but login succeeded")
        } catch let error as LoginViewModel.Error {
            XCTAssertEqual(error, .invalidEmailOrPassword)
            expectation.fulfill()
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}

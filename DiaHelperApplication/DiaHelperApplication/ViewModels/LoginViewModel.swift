//
//  LoginViewModel.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.11.24.
//

import Foundation

class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var onLoadingStateChange: ((Bool) -> Void)?
    var api: LoginInterface
    
    init(api: LoginInterface) {
        self.api = api
    }
    
    enum Error: Swift.Error {
        case incorrectEmail
        case incorrectPassword
        case invalidEmailOrPassword
        case unexpected
        
        var description: String {
            switch self {
            case .incorrectEmail:
                return "IncorrectEmail"
            case .incorrectPassword:
                return "Incorrect password"
            case .invalidEmailOrPassword:
                return "Invalid email or password"
            case .unexpected:
                return "Unexpexted"
            }
        }
    }
    
    func login() async throws {
        onLoadingStateChange?(true)
        do {
            let _ = try await api.loginUser(email: email, password: password)
            onLoadingStateChange?(false)
        } catch let error as LoginError {
            onLoadingStateChange?(false)
            throw error.loginViewModelError
        }
    }
}

private extension LoginError {
    var loginViewModelError: LoginViewModel.Error {
        switch self {
        case .userNotFound:
            return .incorrectEmail
        case .invalidPassword:
            return .incorrectPassword
        case .invalidEmailOrPassword:
            return .invalidEmailOrPassword
        }
    }
}



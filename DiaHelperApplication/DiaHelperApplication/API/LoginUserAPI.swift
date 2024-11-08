//
//  LoginUserAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 30.01.24.
//

import Foundation

protocol LoginInterface {
    func loginUser(email: String, password: String) async throws -> User
}

class LoginUserAPI: LoginInterface {
    func loginUser(email: String, password: String) async throws -> User {
        guard let url = API.url(for: .login) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            throw NetworkError.encodingError
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let loginResponse = try decoder.decode(LoginResponse.self, from: data)
            
            let token = loginResponse.token
            print(token)
            
            let newUser = User(email: loginResponse.user.email, username: loginResponse.user.username, nightscout: loginResponse.user.nightscout, birtDate: loginResponse.user.birtDate, yearOfDiagnosis: loginResponse.user.yearOfDiagnosis, pumpModel: PumpModel(rawValue: loginResponse.user.pumpModel) ?? .Other, sensorModel: SensorModel(rawValue: loginResponse.user.sensorModel) ?? .Other, insulinType: InsulinType(rawValue: loginResponse.user.insulinType) ?? .Other)
            
            UserManager.shared.setCurrentUserId(id: loginResponse.user.id)
            UserManager.shared.setToken(token_: token)
            UserManager.shared.saveUser(newUser)
            
            return newUser
        } catch let loginError as LoginError {
            switch loginError {
            case .userNotFound:
                throw LoginError.userNotFound
            case .invalidPassword:
                throw LoginError.invalidPassword
            case .invalidEmailOrPassword:
                throw LoginError.invalidEmailOrPassword
            }
        } catch {
            throw LoginError.invalidEmailOrPassword
        }
    }
}


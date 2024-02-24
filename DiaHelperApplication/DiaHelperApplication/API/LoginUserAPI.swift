//
//  LoginUserAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 30.01.24.
//

import Foundation

class LoginUserAPI {
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
            
            let newUser = User(email: loginResponse.email, username: loginResponse.username, nightscout: loginResponse.nightscout, birtDate: loginResponse.birtDate, yearOfDiagnosis: loginResponse.yearOfDiagnosis, pumpModel: PumpModel(rawValue: loginResponse.pumpModel) ?? .Other, sensorModel: SensorModel(rawValue: loginResponse.sensorModel) ?? .Other, insulinType: InsulinType(rawValue: loginResponse.insulinType) ?? .Other)
            
            UserManager.shared.setCurrentUserId(id: loginResponse.id)
            UserManager.shared.saveUser(newUser)
            
            return newUser
        }catch {
            throw LoginError.invalidEmailOrPassword
        }
    }
}


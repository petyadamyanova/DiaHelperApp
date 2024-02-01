//
//  LoginUserAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 30.01.24.
//

import Foundation

class LoginUserAPI {
    func loginUser(email: String, password: String) {
        guard let url = URL(string: "http://localhost:8080/users/login") else { return }

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
            print("Error encoding parameters: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                    
                    print("Login Response: \(loginResponse)")
                    
                    let newUser = User(name: loginResponse.username, email: loginResponse.email, username: loginResponse.username, nightscout: loginResponse.nightscout, birtDate: loginResponse.birtDate, yearOfDiagnosis: loginResponse.yearOfDiagnosis, pumpModel: PumpModel(rawValue: loginResponse.pumpModel) ?? .Other, sensorModel: SensorModel(rawValue: loginResponse.sensorModel) ?? .Other, insulinType: InsulinType(rawValue: loginResponse.insulinType) ?? .Other)
                    
                    UserManager.shared.setCurrentUserId(id: loginResponse.id)

                    UserManager.shared.saveUser(newUser)
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }

        task.resume()
    }
}

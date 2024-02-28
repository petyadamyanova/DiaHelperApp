//
//  RegisterUserAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 29.01.24.
//

import Foundation

class RegisterUserAPI{
    func registerUser(name: String, email: String, username: String, password: String, password2: String, nightscout: String, birtDate: String, yearOfDiagnosis: String, pumpModel: String, sensorModel: String, insulinType: String) async throws {
            guard let url = API.url(for: .registerUser) else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let parameters: [String: Any] = [
                "name": name,
                "email": email,
                "username": username,
                "password": password,
                "confirmPassword": password2,
                "nightscout": nightscout,
                "birtDate": birtDate,
                "yearOfDiagnosis": yearOfDiagnosis,
                "pumpModel": pumpModel,
                "sensorModel": sensorModel,
                "insulinType": insulinType
            ]

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                print("Error encoding parameters: \(error)")
                throw error
            }
        
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                print("Server Response: \(String(data: data, encoding: .utf8) ?? "")")
            } catch {
                print("Error: \(error)")
                throw error
            }
        }
}


//
//  LoginUserAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 30.01.24.
//

import Foundation

class LoginUserAPI {
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/users/login") else {
            completion(.failure(NetworkError.invalidURL))
            return
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
            completion(.failure(NetworkError.encodingError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode == 401 {
                    completion(.failure(NetworkError.userNotFound))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let loginResponse = try decoder.decode(LoginResponse.self, from: data)

                        let newUser = User(name: loginResponse.username, email: loginResponse.email, username: loginResponse.username, nightscout: loginResponse.nightscout, birtDate: loginResponse.birtDate, yearOfDiagnosis: loginResponse.yearOfDiagnosis, pumpModel: PumpModel(rawValue: loginResponse.pumpModel) ?? .Other, sensorModel: SensorModel(rawValue: loginResponse.sensorModel) ?? .Other, insulinType: InsulinType(rawValue: loginResponse.insulinType) ?? .Other)

                        UserManager.shared.setCurrentUserId(id: loginResponse.id)
                        UserManager.shared.saveUser(newUser)

                        completion(.success(newUser))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }

        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case encodingError
    case userNotFound
}


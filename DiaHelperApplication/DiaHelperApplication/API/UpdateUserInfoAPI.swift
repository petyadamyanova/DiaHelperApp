//
//  UpdateUserInfoAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 20.02.24.
//

import Foundation

class UpdateUserInfoAPI {
    static let shared = UpdateUserInfoAPI()

    private init() {}

    func updateUsername(userId: String, newUsername: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-username"
        performUpdateRequest(urlString: urlString, requestBody: UpdateUsernameRequest(newUsername: newUsername), completion: completion)
    }

    func updateEmail(userId: String, newEmail: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-email"
        performUpdateRequest(urlString: urlString, requestBody: UpdateEmailRequest(newEmail: newEmail), completion: completion)
    }

    func updateNightscout(userId: String, newNightscout: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-nightscout"
        performUpdateRequest(urlString: urlString, requestBody: UpdateNightscoutRequest(newNightscout: newNightscout), completion: completion)
    }

    func updateBirthDate(userId: String, newBirthDate: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-birthdate"
        performUpdateRequest(urlString: urlString, requestBody: UpdateBirthDateRequest(newBirthDate: newBirthDate), completion: completion)
    }

    func updateInsulinType(userId: String, newInsulinType: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-insulin-type"
        performUpdateRequest(urlString: urlString, requestBody: UpdateInsulinTypeRequest(newInsulinType: newInsulinType), completion: completion)
    }

    func updatePumpModel(userId: String, newPumpModel: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-pump-model"
        performUpdateRequest(urlString: urlString, requestBody: UpdatePumpModelRequest(newPumpModel: newPumpModel), completion: completion)
    }
    
    func updateSensorModel(userId: String, newSensorModel: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-sensor-model"
        performUpdateRequest(urlString: urlString, requestBody: UpdateSensorModelRequest(newSensorModel: newSensorModel), completion: completion)
    }

    func updateYearOfDiagnosis(userId: String, newYearOfDiagnosis: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-year-of-diagnosis"
        performUpdateRequest(urlString: urlString, requestBody: UpdateYearOfDiagnosisRequest(newYearOfDiagnosis: newYearOfDiagnosis), completion: completion)
    }

    private func performUpdateRequest<T: Codable>(urlString: String, requestBody: T, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(requestBody)
        } catch {
            print("Error encoding update request: \(error)")
            completion(error)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(error)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }
}

struct UpdateUsernameRequest: Codable {
    let newUsername: String
}

struct UpdateEmailRequest: Codable {
    let newEmail: String
}

struct UpdateNightscoutRequest: Codable {
    let newNightscout: String
}

struct UpdateBirthDateRequest: Codable {
    let newBirthDate: String
}

struct UpdateInsulinTypeRequest: Codable {
    let newInsulinType: String
}

struct UpdatePumpModelRequest: Codable {
    let newPumpModel: String
}

struct UpdateSensorModelRequest: Codable {
    let newSensorModel: String
}

struct UpdateYearOfDiagnosisRequest: Codable {
    let newYearOfDiagnosis: String
}

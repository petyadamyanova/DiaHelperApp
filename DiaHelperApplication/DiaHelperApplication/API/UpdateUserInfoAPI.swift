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
        let endpoint = APIEndpoint.updateUsername(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdateUsernameRequest(newUsername: newUsername), completion: completion)
    }

    func updateEmail(userId: String, newEmail: String, completion: @escaping (Error?) -> Void) {
        let endpoint = APIEndpoint.updateEmail(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdateEmailRequest(newEmail: newEmail), completion: completion)
    }

    func updateNightscout(userId: String, newNightscout: String, completion: @escaping (Error?) -> Void) {
        let endpoint = APIEndpoint.updateNightscout(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdateNightscoutRequest(newNightscout: newNightscout), completion: completion)
    }

    func updateBirthDate(userId: String, newBirthDate: String, completion: @escaping (Error?) -> Void) {
        let endpoint = APIEndpoint.updateBirthDate(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdateBirthDateRequest(newBirthDate: newBirthDate), completion: completion)
    }

    func updateInsulinType(userId: String, newInsulinType: String, completion: @escaping (Error?) -> Void) {
        let endpoint = APIEndpoint.updateInsulinType(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdateInsulinTypeRequest(newInsulinType: newInsulinType), completion: completion)
    }

    func updatePumpModel(userId: String, newPumpModel: String, completion: @escaping (Error?) -> Void) {
        let endpoint = APIEndpoint.updatePumpModel(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdatePumpModelRequest(newPumpModel: newPumpModel), completion: completion)
    }
    
    func updateSensorModel(userId: String, newSensorModel: String, completion: @escaping (Error?) -> Void) {
        let endpoint = APIEndpoint.updateSensorModel(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdateSensorModelRequest(newSensorModel: newSensorModel), completion: completion)
    }

    func updateYearOfDiagnosis(userId: String, newYearOfDiagnosis: String, completion: @escaping (Error?) -> Void) {
        let endpoint = APIEndpoint.updateYearOfDiagnosis(userId: userId)
        performUpdateRequest(endpoint: endpoint, requestBody: UpdateYearOfDiagnosisRequest(newYearOfDiagnosis: newYearOfDiagnosis), completion: completion)
    }

    private func performUpdateRequest<T: Codable>(endpoint: APIEndpoint, requestBody: T, completion: @escaping (Error?) -> Void) {
        
        guard let url = API.url(for: endpoint, userId: nil) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserManager.shared.getToken())", forHTTPHeaderField: "Authorization")

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

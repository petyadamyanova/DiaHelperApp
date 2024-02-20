//
//  UpdateBirthDateAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 20.02.24.
//

import Foundation

class UpdateBirthDateAPI {
    static let shared = UpdateBirthDateAPI()

    private init() {}

    func updateBirthDate(userId: String, newBirthDate: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-birthdate"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let updateRequest = UpdateBirthDateRequest(newBirthDate: newBirthDate)

        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(updateRequest)
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

struct UpdateBirthDateRequest: Codable {
    let newBirthDate: String
}

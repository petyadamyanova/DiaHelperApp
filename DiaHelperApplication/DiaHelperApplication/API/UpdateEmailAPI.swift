//
//  UpdateEmailAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 12.02.24.
//

import Foundation

class UpdateEmailAPI {
    static let shared = UpdateEmailAPI()

    private init() {}

    func updateEmail(userId: String, newEmail: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-email"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let updateRequest = UpdateEmailRequest(newEmail: newEmail)

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

struct UpdateEmailRequest: Codable {
    let newEmail: String
}

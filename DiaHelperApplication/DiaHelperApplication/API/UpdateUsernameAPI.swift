//
//  UpdateUsernameAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 12.02.24.
//

import Foundation
import UIKit

class UpdateUsernameAPI {
    static let shared = UpdateUsernameAPI()

    private init() {}

    func updateUsername(userId: String, newUsername: String, completion: @escaping (Error?) -> Void) {
        let urlString = "http://localhost:8080/users/\(userId)/update-username"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let updateRequest = UpdateUsernameRequest(newUsername: newUsername)

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

struct UpdateUsernameRequest: Codable {
    let newUsername: String
}

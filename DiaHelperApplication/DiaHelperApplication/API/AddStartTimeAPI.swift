//
//  AddStartTimeAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 15.02.24.
//

import Foundation

class AddStartTimeAPI {
    func addStartTime(userId: String, startTime: StartTimes, completion: @escaping (Error?) -> Void) {
        guard let url = API.url(for: .addStartTime(userId: userId)) else {
            print("Invalid URL.")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(startTime)
        } catch {
            print("Error encoding start time: \(error)")
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

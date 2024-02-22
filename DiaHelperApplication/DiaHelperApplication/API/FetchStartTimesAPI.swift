//
//  FetchStartTimesAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 15.02.24.
//

import Foundation

import Foundation
    
class FetchStartTimesAPI {
    static let shared = FetchStartTimesAPI()

    func fetchStartTimes(for userId: UUID, completion: @escaping ([StartTimes]?) -> Void) {
        guard let url = API.url(for: .fetchStartTimes(userId: userId.uuidString)) else {
            print("Invalid URL.")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let startTimes = try decoder.decode([StartTimes].self, from: data)

                    DispatchQueue.main.async {
                        completion(startTimes.reversed())
                    }
                } catch {
                    print("Error decoding response: \(error)")
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}

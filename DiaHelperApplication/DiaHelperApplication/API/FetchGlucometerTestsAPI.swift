//
//  FetchGlucometerTestsAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.02.24.
//

import Foundation
import UIKit

class FetchGlucometerTestsAPI {
    static let shared = FetchGlucometerTestsAPI()
    
    func fetchGlucometerTests(for userId: UUID, completion: @escaping ([GlucometerBloodSugarTest]?) -> Void){
        guard let url = API.url(for: .fetchTest(userId: userId.uuidString)) else {
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
                    let glucometerTests = try decoder.decode([GlucometerBloodSugarTest].self, from: data)

                    DispatchQueue.main.async {
                        completion(glucometerTests.reversed())
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

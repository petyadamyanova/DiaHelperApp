//
//  AddMealApi.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 1.02.24.
//

import Foundation

class AddMealAPI {
    func addMeal(userId: String, meal: Meal, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "http://localhost:8080/users/\(userId)/meals") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(meal)
        } catch {
            print("Error encoding meal: \(error)")
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

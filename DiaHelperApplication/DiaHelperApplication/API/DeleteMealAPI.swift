//
//  DeleteMealAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 7.02.24.
//

import Foundation

class DeleteMealAPI {
    func deleteMeal(userId: String, mealId: String, completion: @escaping (Error?) -> Void) {
        /*guard let url = URL(string: "http://localhost:8080/users/\(userId)/meals/\(mealId)") else {
            completion(nil)
            return
        }*/
        
        guard let url = API.url(for: .deleteMeal(userId: userId, mealId: mealId)) else {
            print("Invalid URL.")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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

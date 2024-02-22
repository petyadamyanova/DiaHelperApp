//
//  FetchMealsAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 1.02.24.
//

import Foundation

class FetchMealsAPI {
    static let shared = FetchMealsAPI()
    func fetchMeals(for userId: UUID, completion: @escaping ([Meal]?) -> Void) {
        guard let url = API.url(for: .fetchMeals(userId: userId.uuidString)) else {
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
                    let meals = try decoder.decode([Meal].self, from: data)

                    DispatchQueue.main.async {
                        completion(meals.reversed())
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

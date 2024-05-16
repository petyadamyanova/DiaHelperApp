//
//  AddMealApi.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 1.02.24.
//

import Foundation

class AddMealAPI {
    func addMeal(userId: String, meal: Meal) async throws {
        guard let url = API.url(for: .addMeal(userId: userId)) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserManager.shared.getToken())", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(meal)
        
        try await URLSession.shared.data(for: request)
    }
}

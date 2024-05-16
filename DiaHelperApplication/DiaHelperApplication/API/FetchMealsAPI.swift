//
//  FetchMealsAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 1.02.24.
//

import Foundation

class FetchMealsAPI {
    static let shared = FetchMealsAPI()
    
    func fetchMeals(for userId: UUID) async throws -> [Meal] {
        guard let url = API.url(for: .fetchMeals(userId: userId.uuidString)) else {
            print("Invalid URL.")
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserManager.shared.getToken())", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        return try decoder.decode([Meal].self, from: data).reversed()
    }
}

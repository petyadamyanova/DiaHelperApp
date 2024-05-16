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
    
    func fetchGlucometerTests(for userId: UUID) async throws -> [GlucometerBloodSugarTest] {
            guard let url = API.url(for: .fetchTest(userId: userId.uuidString)) else {
                throw NetworkError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(UserManager.shared.getToken())", forHTTPHeaderField: "Authorization")

            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode([GlucometerBloodSugarTest].self, from: data).reversed()
        }
}

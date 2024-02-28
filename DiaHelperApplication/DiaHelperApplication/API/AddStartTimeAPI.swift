//
//  AddStartTimeAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 15.02.24.
//

import Foundation

class AddStartTimeAPI {
    func addStartTime(userId: String, startTime: StartTimes) async throws {
            guard let url = API.url(for: .addStartTime(userId: userId)) else {
                throw NetworkError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let encoder = JSONEncoder()
            do {
                request.httpBody = try encoder.encode(startTime)
            } catch {
                throw error
            }

            try await URLSession.shared.data(for: request)
        }
}

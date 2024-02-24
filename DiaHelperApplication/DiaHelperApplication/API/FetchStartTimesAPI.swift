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

    func fetchStartTimes(for userId: UUID) async throws -> [StartTimes] {
        guard let url = API.url(for: .fetchStartTimes(userId: userId.uuidString)) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let startTimes = try decoder.decode([StartTimes].self, from: data)

        return startTimes.reversed()
    }
}

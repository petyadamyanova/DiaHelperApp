//
//  FetchGlucometerTestsAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.02.24.
//

import Foundation
import UIKit
import Combine

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
    
    func fetchGlucometerTestsPublisher(for userId: UUID) -> AnyPublisher<[GlucometerBloodSugarTest], Error> {
        guard let url = API.url(for: .fetchTest(userId: userId.uuidString)) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserManager.shared.getToken())", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, _ in
                let decoder = JSONDecoder()
                return try decoder.decode([GlucometerBloodSugarTest].self, from: data).reversed()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

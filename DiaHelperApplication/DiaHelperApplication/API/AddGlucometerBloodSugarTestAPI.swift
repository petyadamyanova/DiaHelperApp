//
//  addGlucometerBloodSugarTestAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 5.02.24.
//

import Foundation

class AddGlucometerBloodSugarTestAPI{
    func addGlucometerBloodSugarTest(_ test: GlucometerBloodSugarTest, forUserId userId: String) async throws {
        
        guard let url = API.url(for: .addGlucometerBloodSugarTest(userId: userId)) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(test)
        
        try await URLSession.shared.data(for: request)
    }

}

//
//  FetchAppointmentsAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 31.03.24.
//

import Foundation

class FetchAppointmentsAPI {
    static let shared = FetchAppointmentsAPI()
    
    func fetchAppointments(for userId: UUID) async throws -> [Appointment] {
        guard let url = API.url(for: .fetchAppointments(userId: userId.uuidString)) else {
            print("Invalid URL.")
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        return try decoder.decode([Appointment].self, from: data).reversed()
    }
}

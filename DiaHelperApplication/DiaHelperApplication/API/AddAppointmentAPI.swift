//
//  AddAppointmentAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 31.03.24.
//

import Foundation

class AddAppointmentAPI {
    func addAppointment(userId: String, appoiment: Appointment) async throws {
        guard let url = API.url(for: .addAppointment(userId: userId)) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(appoiment)
        
        try await URLSession.shared.data(for: request)
    }
}

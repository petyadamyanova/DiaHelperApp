//
//  DeleteAppointmentAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 19.05.24.
//

import Foundation

class DeleteAppointmentAPI {
    func deleteAppointment(userId: String, appointmentId: String, completion: @escaping (Error?) -> Void) {
        
        guard let url = API.url(for: .deleteAppointment(userId: userId, appointmentId: appointmentId)) else {
            print("Invalid URL.")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("Bearer \(UserManager.shared.getToken())", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(error)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }
}

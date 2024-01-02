//
//  NightscoutAPI.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.12.23.
//

import Foundation

class NightscoutAPI {
    static func takeBloodSugar(withID nightscout: String, completion: @escaping ([ApiReading]?) -> Void) {
        let urlString = "https://" + nightscout + "/api/v1/entries"
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                } else if let data = data {
                    if let dataString = String(data: data, encoding: .utf8) {
                        let apiReadings = extractApiReadings(from: dataString)
                        completion(apiReadings)
                    } else {
                        print("Error with converting data.")
                        completion(nil)
                    }
                }
            }
            
            task.resume()
        }
    }

    private static func extractApiReadings(from text: String) -> [ApiReading] {
        var apiReadings = [ApiReading]()
        
        let lines = text.components(separatedBy: "\n")
        for line in lines {
            let components = line.components(separatedBy: "\t")
            if components.count >= 3 {
                if let value = Int(components[2]) {
                    let apiReading = ApiReading(date: components[0], value: value)
                    apiReadings.append(apiReading)
                }
            }
        }

        return apiReadings
    }
}

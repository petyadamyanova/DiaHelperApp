//
//  BloodSugarApi.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 15.11.23.
//

import Foundation

func extractThirdArgument(from text: String) -> [String] {
    var thirdArguments = [String]()

    let lines = text.components(separatedBy: "\n")
    for line in lines {
        let components = line.components(separatedBy: "\t")
        if components.count >= 3 {
            let thirdArgument = components[2]
            thirdArguments.append(thirdArgument)
        }
    }

    return thirdArguments
}

func takeBloodSugar(withURL nightscout: String, completion: @escaping (String?) -> Void) {
   let urlString = "https://" + nightscout + "/api/v1/entries"
    
    print(nightscout)
    
    if let url = URL(string: "https://petiadam.nightscout.bg/api/v1/entries") {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                if let dataString = String(data: data, encoding: .utf8) {
                    let results = extractThirdArgument(from: dataString)
                    if let firstElement = results.first {
                        completion(firstElement)
                    } else {
                        completion(nil)
                    }
                } else {
                    print("Error with converting data.")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}

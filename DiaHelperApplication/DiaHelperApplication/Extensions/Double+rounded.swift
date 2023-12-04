//
//  Double+rounded.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.12.23.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

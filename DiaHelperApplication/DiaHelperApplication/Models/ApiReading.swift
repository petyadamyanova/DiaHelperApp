//
//  ApiReading.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 11.12.23.
//

import Foundation

struct ApiReading: Identifiable {
    let id = UUID()
    let date: String
    let value: Int
}

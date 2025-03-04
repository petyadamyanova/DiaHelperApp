//
//  BloodSugarEntry.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.03.25.
//

import WidgetKit

struct BloodSugarEntry: TimelineEntry {
    let date: Date
    let bloodSugar: String
    let readings: [ApiReading]
}

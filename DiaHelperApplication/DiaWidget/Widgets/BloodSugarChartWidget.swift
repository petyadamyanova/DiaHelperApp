//
//  BloodSugarChartWidget.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.03.25.
//

import SwiftUI
import WidgetKit

struct BloodSugarChartWidget: Widget {
    let kind: String = "BloodSugarChartWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: BloodSugarProvider(nightscout: "petiadam.nightscout.bg")) { entry in
            BloodSugarAndChartView(entry: entry)
        }
        .configurationDisplayName("Blood Sugar Chart")
        .description("Shows a graph of your blood sugar levels.")
        .supportedFamilies([.systemMedium, .systemLarge]) 
    }
}

#Preview(as: .systemSmall) {
    BloodSugarChartWidget()
} timeline: {
    BloodSugarEntry(date: Date(), bloodSugar: "5.6", readings: [
        ApiReading(date: "2025-02-25T10:29:45.456Z", value: 155),
        ApiReading(date: "2025-02-25T10:22:45.456Z", value: 157),
        ApiReading(date: "2025-02-25T10:16:45.456Z", value: 170),
        ApiReading(date: "2025-02-25T10:12:45.456Z", value: 145),
        ApiReading(date: "2025-02-25T10:07:44.965Z", value: 158),
        ApiReading(date: "2025-02-25T10:02:45.229Z", value: 180),
        ApiReading(date: "2025-02-25T09:57:45.155Z", value: 157),
        ApiReading(date: "2025-02-25T09:52:44.829Z", value: 100),
        ApiReading(date: "2025-02-25T09:47:45.345Z", value: 155)
    ])
}

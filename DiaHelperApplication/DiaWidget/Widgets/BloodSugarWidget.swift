//
//  BloodSugarWidget.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.03.25.
//

import SwiftUI
import WidgetKit

@main
struct BloodSugarWidget: Widget {
    let kind: String = "BloodSugarWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: BloodSugarProvider(nightscout: "petiadam.nightscout.bg")) { entry in
            BloodSugarView(entry: entry)
        }
        .configurationDisplayName("Blood Sugar Widget")
        .description("Shows your latest blood sugar reading.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall
) {
    BloodSugarWidget()
} timeline: {
    BloodSugarEntry(date: Date(), bloodSugar: "5.6", readings: [])
}

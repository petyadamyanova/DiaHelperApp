//
//  BloodSugarAndChartView.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.03.25.
//

import SwiftUI

struct BloodSugarAndChartView: View {
    var entry: BloodSugarProvider.Entry

    var body: some View {
        VStack {
            Text(entry.bloodSugar)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.red)
            BloodSugarChartView(readings: entry.readings)
                .frame(height: 100)
        }
        .containerBackground(Color.clear, for: .widget)
    }
}

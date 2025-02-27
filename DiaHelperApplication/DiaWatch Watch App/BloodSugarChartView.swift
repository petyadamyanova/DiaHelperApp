//
//  BloodSugarChartView.swift
//  BloodSugar Watch App
//
//  Created by Petya Damyanova on 25.02.25.
//

import SwiftUI
import Charts

struct BloodSugarChartView: View {
    let readings: [ApiReading]
    
    init(readings: [ApiReading]){
        self.readings = readings
    }
    
    var yAxisMin: Double {
        let minValue = readings.map { Double($0.value) / 18.0 }.min() ?? 0
        return minValue - 2
    }
    
    var yAxisMax: Double {
        let maxValue = readings.map { Double($0.value) / 18.0 }.max() ?? 10
        return maxValue + 2
    }
    
    var body: some View {
        Chart {
            ForEach(readings) { reading in
                LineMark(
                    x: .value("Time", reading.date),
                    y: .value("Value", (Double(reading.value) / 18.0).rounded(toPlaces: 2))
                )
                .foregroundStyle(.blue)
                //.symbol(.circle)
            }
        }
        .padding()
        .chartYAxis { AxisMarks(position: .leading) }
        .chartXAxis(.hidden)
        .chartYScale(domain: yAxisMin...yAxisMax)
        .frame(width: 180, height: 120)
    }
}

#Preview {
    BloodSugarChartView(readings: [
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


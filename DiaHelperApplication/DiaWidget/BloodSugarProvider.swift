//
//  BloodSugarProvider.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.03.25.
//

import WidgetKit

struct BloodSugarProvider: @preconcurrency TimelineProvider {
    var nightscout: String
    
    init(nightscout: String) {
        self.nightscout = nightscout
    }
    
    func placeholder(in context: Context) -> BloodSugarEntry {
        BloodSugarEntry(date: Date(), bloodSugar: "-", readings: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (BloodSugarEntry) -> Void) {
        let entry = BloodSugarEntry(date: Date(), bloodSugar: "5.6", readings: [])
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<BloodSugarEntry>) -> Void) {
        let viewModel = BloodSugarViewModel(nightscout: nightscout)
        
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            let entry = BloodSugarEntry(date: Date(), bloodSugar: viewModel.bloodSugar, readings: viewModel.readings)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            
            completion(timeline)
        }
    }
}

//
//  BloodSugarProvider.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.03.25.
//

import WidgetKit
import SwiftUI

struct BloodSugarProvider: TimelineProvider {
    private var viewModel: BloodSugarViewModel
    
    @MainActor
    init(nightscout: String) {
        viewModel = BloodSugarViewModel(nightscout: nightscout)
    }
    
    func placeholder(in context: Context) -> BloodSugarEntry {
        BloodSugarEntry(date: Date(), bloodSugar: "-", readings: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (BloodSugarEntry) -> Void) {
        let entry = BloodSugarEntry(date: Date(), bloodSugar: "5.6", readings: [])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<BloodSugarEntry>) -> Void) {
        let entry = BloodSugarEntry(date: Date(), bloodSugar: viewModel.bloodSugar, readings: viewModel.readings)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

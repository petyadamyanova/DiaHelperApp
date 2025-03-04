//
//  BloodSugarWidgetView.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.03.25.
//

import SwiftUI
import WidgetKit

struct BloodSugarView: View {
    var entry: BloodSugarProvider.Entry
    
    var body: some View {
        VStack {
            Text(entry.bloodSugar)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.red)
        }
        .containerBackground(Color.black, for: .widget)
    }
}

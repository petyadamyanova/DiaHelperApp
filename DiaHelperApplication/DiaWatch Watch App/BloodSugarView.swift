//
//  BloodSugarView.swift
//  Quotes Watch App
//
//  Created by Petya Damyanova on 25.02.25.
//

import SwiftUI

struct BloodSugarView: View {
    @StateObject private var viewModel: BloodSugarViewModel
    
    init(nightscout: String) {
        _viewModel = StateObject(wrappedValue: BloodSugarViewModel(nightscout: nightscout))
    }

    var body: some View {
        VStack {
            Text("Blood Sugar")
                .font(.headline)
            Text(viewModel.bloodSugar)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.red)
                .padding()
            BloodSugarChartView(readings: viewModel.readings)
        }
    }
}

#Preview {
    BloodSugarView(nightscout: "petiadam.nightscout.bg")
}

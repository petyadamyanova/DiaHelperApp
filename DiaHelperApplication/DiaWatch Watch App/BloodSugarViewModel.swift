//
//  BloodSugarViewModel.swift
//  BloodSugar Watch App
//
//  Created by Petya Damyanova on 26.02.25.
//

import Foundation

final class BloodSugarViewModel: ObservableObject {
    @Published var bloodSugar: String = "-"
    @Published var readings: [ApiReading] = []
    private let nightscout: String
    private var timer: Timer?

    @MainActor
    init(nightscout: String) {
        self.nightscout = nightscout
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(fetchBloodSugar), userInfo: nil, repeats: true)
        fetchBloodSugar()
    }

    @objc private func fetchBloodSugar() {
        NightscoutAPI.takeBloodSugar(withID: nightscout) { [weak self] readings in
            if let readings = readings, let firstReading = readings.first {
                let roundedValue = (Double(firstReading.value) / 18.0).rounded(toPlaces: 2)
                Task { @MainActor in
                    self?.bloodSugar = String(roundedValue)
                    self?.readings = readings.reversed()
                }
            }
        }
        
    }
}

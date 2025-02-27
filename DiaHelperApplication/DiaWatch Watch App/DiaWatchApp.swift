//
//  DiaWatchApp.swift
//  DiaWatch Watch App
//
//  Created by Petya Damyanova on 27.02.25.
//

import SwiftUI

@main
struct DiaWatch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            BloodSugarView(nightscout: "petiadam.nightscout.bg")
        }
    }
}

//
//  DiaHelperApp.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 1.11.24.
//

import SwiftUI

@main
struct DiaHelperApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStackView()
        }
    }
}

struct NavigationStackView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            StartView(path: $path)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .login:
                        LoginView()
                    case .register:
                        RegisterView()
                    }
                }
        }
    }
}

enum Destination: Hashable {
    case login
    case register
}

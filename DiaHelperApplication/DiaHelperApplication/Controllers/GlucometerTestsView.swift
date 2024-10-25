//
//  GlucometerTestsView.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 22.10.24.
//

import SwiftUI

protocol GlucometerDataSource {
    func getData() async -> [GlucometerBloodSugarTest]
}

class APIDataSource: GlucometerDataSource {
    func getData() async -> [GlucometerBloodSugarTest] {
        guard let userID = UUID(uuidString: UserManager.shared.getCurrentUserId()) else {
            return []
        }
        
        do {
            return try await FetchGlucometerTestsAPI.shared.fetchGlucometerTests(for: userID)
        } catch {
            print("Error fetching glucometer tests: \(error)")
            return []
        }
    }
}

class DummyDataSource: GlucometerDataSource {
    func getData() async -> [GlucometerBloodSugarTest] {
        [
            .init(timestamp: "22/10/2024 16:00", bloodSugar: 5.6),
            .init(timestamp: "22/10/2024 14:40", bloodSugar: 5.3),
            .init(timestamp: "22/10/2024 12:00", bloodSugar: 7.8)
        ]
    }
}


struct GlucometerTestsView : View {
    var dismiss: () -> Void
    @State var glucometerBloodSugarTests: [GlucometerBloodSugarTest] = []
    private var dataSource: GlucometerDataSource
    
    init(dismiss: @escaping () -> Void, dataSource: GlucometerDataSource) {
        self.dismiss = dismiss
        self.dataSource = dataSource
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                welcomeHeader
                separatorView1
                list
            }
            .background(Color("background"))
            .toolbar {
                button
            }
            .onAppear {
                fetchGlucometerTests()
            }
        }
    }
    
    private var button : some View {
        Button(action: {
            self.dismiss()
        }, label: {
            Text("Cancel")
                .frame(maxWidth: .infinity)
        })
    }
    
    private var welcomeHeader: some View {
        Text("Glucometer's data")
            .font(.custom("Baskerville", size: 40))
            .foregroundColor(Color("newBlue"))
    }
    
    private var separatorView1: some View {
        Rectangle()
            .fill(Color.black)
            .frame(height: 1)
            .padding(.horizontal)
    }
    
    private var list: some View {
        List {
            ForEach(glucometerBloodSugarTests) { test in
                GlucometerTestRow(test: test)
            }
        }
        .padding(.horizontal)
        .listStyle(PlainListStyle())
        .background(Color("background"))
    }
    
    private func fetchGlucometerTests() {
        Task {
            glucometerBloodSugarTests = await dataSource.getData()
        }
    }
}

struct GlucometerTestRow: View {
    var test: GlucometerBloodSugarTest
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Blood Sugar: \(String(format: "%.1f", test.bloodSugar))")
                Text(formatTimestamp(test.timestamp))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func formatTimestamp(_ timestamp: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: timestamp) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM d, yyyy h:mm a"
            return "Date: \(displayFormatter.string(from: date))"
        }
        return timestamp
    }
}

#Preview {
    GlucometerTestsView(dismiss: {
        
    }, dataSource: DummyDataSource())
}


//
//  GlucometerTestsView.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 22.10.24.
//

import SwiftUI

struct GlucometerTestsView : View {
    var dismiss: () -> Void
    // private var glucometerBloodSugarTests: [GlucometerBloodSugarTest] = []
    let glucometerBloodSugarTests = [
        GlucometerBloodSugarTest(timestamp: "2024-10-22 16:00:00 +0000", bloodSugar: 5.6),
        GlucometerBloodSugarTest(timestamp: "2024-10-22 15:50:00 +0000", bloodSugar: 7.4),
        GlucometerBloodSugarTest(timestamp: "2024-10-22 14:00:00 +0000", bloodSugar: 8.9),
    ]
    
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
    
    /*private func fetchGlucometerTests() {
        let userID = UUID(uuidString: UserManager.shared.getCurrentUserId())!

        Task {
            do {
                let tests = try await FetchGlucometerTestsAPI.shared.fetchGlucometerTests(for: userID)
                self.glucometerBloodSugarTests = tests
                //self.tableView.reloadData()
            } catch {
                print("Error fetching glucometer tests: \(error)")
            }
        }
        
    }*/
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        if let date = formatter.date(from: timestamp) {
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return timestamp
    }
}

#Preview {
    GlucometerTestsView(dismiss: {
        
    })
}


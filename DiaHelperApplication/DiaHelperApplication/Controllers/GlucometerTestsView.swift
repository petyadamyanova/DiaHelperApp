//
//  GlucometerTestsView.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 22.10.24.
//

import SwiftUI
import Combine

final class GlucometerTestsViewModel: ObservableObject {
    @Published var glucometerBloodSugarTests: [GlucometerBloodSugarTest] = []
    
    private let api: FetchGlucometerTestsAPI
    private var subscriber: AnyCancellable?
        
    init(api: FetchGlucometerTestsAPI = .shared) {
        self.api = api
        
        subscriber = api.fetchGlucometerTestsPublisher(for: UUID(uuidString: UserManager.shared.getCurrentUserId())!)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching glucometer tests: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] tests in
                self?.glucometerBloodSugarTests = tests
            })
    }
    
    deinit {
        subscriber = nil
    }
}


struct GlucometerTestsView : View {
    var dismiss: () -> Void
    @ObservedObject var viewModel: GlucometerTestsViewModel
    
    init(dismiss: @escaping () -> Void, viewModel: GlucometerTestsViewModel) {
        self.dismiss = dismiss
        self.viewModel = viewModel
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
            ForEach(viewModel.glucometerBloodSugarTests) { test in
                GlucometerTestRow(test: test)
            }
        }
        .padding(.horizontal)
        .listStyle(PlainListStyle())
        .background(Color("background"))
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

//#Preview {
//    GlucometerTestsView(dismiss: {
//        
//    }, viewModel: GlucometerTestsViewModel(dataSource: DummyDataSource()))
//}


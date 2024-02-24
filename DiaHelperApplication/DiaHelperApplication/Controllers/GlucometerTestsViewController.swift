//
//  GlucometerTestsViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.02.24.
//

import Foundation
import UIKit

class GlucometerTestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var glucometerTests: [GlucometerBloodSugarTest] = []
    
    public var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Baskerville", size: 40)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Glucometer's data"
        label.textAlignment = .center
        label.textColor = UIColor(named: "newBlue")
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        setupTableView()
        let userID = UUID(uuidString: UserManager.shared.getCurrentUserId())!

        Task {
            do {
                let tests = try await FetchGlucometerTestsAPI.shared.fetchGlucometerTests(for: userID)
                self.glucometerTests = tests
                self.tableView.reloadData()
            } catch {
                print("Error fetching glucometer tests: \(error)")
            }
        }
        addSubviews()
        addViewConstraints()
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    let separatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(separatorView1)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .systemGray6
        tableView.register(GlucometerTestCell.self, forCellReuseIdentifier: "GlucometerTestCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addViewConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            separatorView1.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            separatorView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            separatorView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: separatorView1.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glucometerTests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlucometerTestCell", for: indexPath) as! GlucometerTestCell
        let test = glucometerTests[indexPath.row]
        cell.configure(with: test)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

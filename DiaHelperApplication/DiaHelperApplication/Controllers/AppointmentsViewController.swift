//
//  AppointmentsViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 28.03.24.
//

import Foundation
import UIKit

class AppointmentsViewController: UIViewController, AddAppointmentViewControllerDelegate{
    var appointments:[Appointment] = []
    let tableView = UITableView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        configureTableView()
        setupAddButton()
        addSubviews()
        addViewConstraints()
        
        Task {
            await fetchAppointments()
        }
    }
    
    public var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Baskerville", size: 40)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Appointments"
        label.textAlignment = .center
        label.textColor = UIColor(named: "newBlue")
        
        return label
    }()
    
    public var addButton: UIButton = {
        let color = UIColor(named: "newBrown")
        
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(label)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    private func setupAddButton() {
        let addAction = UIAction(handler: addButtonTapped)
        addButton.addAction(addAction, for: .touchUpInside)
    }
    
    private func addButtonTapped(_ action: UIAction) {
        let addAppointmentViewController = AddAppointmentViewController()
        addAppointmentViewController.delegate = self
        let navController = UINavigationController(rootViewController: addAppointmentViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func addViewConstraints() {
        view.addConstraints([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            addButton.widthAnchor.constraint(equalToConstant: 64),
            addButton.heightAnchor.constraint(equalToConstant: 64),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: label.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16),
        ])
    }
    
    func fetchAppointments() async {
        let userID = UUID(uuidString: UserManager.shared.getCurrentUserId())!
        
        Task {
            do {
                appointments = try await FetchAppointmentsAPI.shared.fetchAppointments(for: userID)
                tableView.reloadData()
            } catch {
                print("Error fetching appointments: \(error)")
            }
        }
    }
    
    func didSubmitAppointment() {
        Task {
            await fetchAppointments()
        }
    }

    func deleteAppointmentFromAPI(appointmentId: String) {
        let userId = UserManager.shared.getCurrentUserId()

        let deleteAppointmentAPI = DeleteAppointmentAPI()
        deleteAppointmentAPI.deleteAppointment(userId: userId, appointmentId: appointmentId) { error in
            if let error = error {
                print("Error deleting appointment from API: \(error)")
            } else {
                print("Appointment deleted successfully from API")
            }
        }
    }
    
}

extension AppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
           
        let appointment = appointments[indexPath.row]
        print(appointment.label)
        cell?.textLabel?.text = "\(appointment.label) - \(appointment.doctor)"
        cell?.detailTextLabel?.text = "date: \(appointment.date), place: \(appointment.place)"
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        cell?.detailTextLabel?.textColor = UIColor.lightGray
        
        return cell!
    }
}

//
//  AppointmentsViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 28.03.24.
//

import Foundation
import UIKit

class AppointmentsViewController: UIViewController{
    var appointments:[Appointment] = []
    let tableView = UITableView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        addSubviews()
        addStackViewConstraints()
        configureTableView()
        
        Task {
            await fetchAppointments()
        }
    }
    
    internal var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center

        return stackView
    }()
    
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
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(separatorView1)
        view.addSubview(stackView)
        view.addSubview(tableView)
    }
    
    private func configureTableView() {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.dataSource = self
            tableView.delegate = self
            tableView.isScrollEnabled = true
            tableView.backgroundColor = .white
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    
    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            tableView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func fetchAppointments() async {
        let userID = UUID(uuidString: UserManager.shared.getCurrentUserId())!
        
        /*let appointment = Appointment(label: "Gynecologist", doctor: "Dr.Ivanova", date: "22.07.2024", place: "St.Vazov 23")
        
        let addMAppointmentApi = AddAppointmentAPI()
    
        do {
            try await addMAppointmentApi.addAppointment(userId: userID.uuidString, appoiment: appointment)
        }catch {
            print("Error adding appointment: \(error)")
        }*/
        
        Task {
            do {
                appointments = try await FetchAppointmentsAPI.shared.fetchAppointments(for: userID)
                tableView.reloadData()
            } catch {
                print("Error fetching appointments: \(error)")
            }
        }
    }
    
}

extension AppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           
        let appointment = appointments[indexPath.row]
        print(appointment.label)
        cell.textLabel?.text = "\(appointment.label) - \(appointment.doctor)"
        cell.detailTextLabel?.text = "\(appointment.date) at \(appointment.place)"
             
        
        return cell
    }
}

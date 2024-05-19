//
//  AddAppointmentViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 18.05.24.
//

import Foundation
import UIKit


protocol AddAppointmentViewControllerDelegate: AnyObject {
    func didSubmitAppointment()
}

class AddAppointmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    weak var delegate: AddAppointmentViewControllerDelegate?
    private let tableView = UITableView()
    private let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSubmitButton()
        setupErrorLabel()
        addSubviews()
        addViewConstraints()
        
        
        setupDismissButton()
        view.backgroundColor = .systemGray6
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.tableView.layer.borderColor = UIColor.systemGray6.cgColor
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.cornerRadius = 10;
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView(style: .medium)
       indicator.hidesWhenStopped = true
       return indicator
    }()
    
    public var errorField: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Error"
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private func addSubviews() {
        view.addSubview(tableView)
        
        view.addSubview(submitButton)
        view.addSubview(errorField)
        view.addSubview(activityIndicator)
    }
    
    func addViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16 + (44 * 4 )),
            
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16 + 16),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            
            errorField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            errorField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            errorField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            
            activityIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            activityIndicator.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 32)
        
        ])
    }
    
    private func setupSubmitButton(){
        let color = UIColor(named: "newBrown")
        submitButton.setTitle("Submit", for: .normal)
        
        submitButton.setTitleColor(color, for: .normal)
        submitButton.tintColor = UIColor(named: "newBlue")
        
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        submitButton.configuration = buttonConfiguration

        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        let submitAction = UIAction { [weak self] action in
            Task {
                await self?.didtapSubmitButton(action)
            }
        }
        submitButton.addAction(submitAction, for: .touchUpInside)
    }
    
    private func didtapSubmitButton(_ action: UIAction) async {
        guard let title = getCellTextFieldText(indexPath: IndexPath(row: 0, section: 0)),
             let doctor = getCellTextFieldText(indexPath: IndexPath(row: 1, section: 0)),
             let date = getCellTextFieldText(indexPath: IndexPath(row: 2, section: 0)),
             let place = getCellTextFieldText(indexPath: IndexPath(row: 3, section: 0)) else {
           showError(message: "All fields are required.")
           return
       }
       
       let appointment = Appointment(label: title, doctor: doctor, date: date, place: place)
       
       do {
           activityIndicator.startAnimating()
           
           let api = AddAppointmentAPI()
           try await api.addAppointment(userId: UserManager.shared.getCurrentUserId(), appointment: appointment)
           
           activityIndicator.stopAnimating()
           
           DispatchQueue.main.async {
               self.delegate?.didSubmitAppointment()
               self.dismiss(animated: true)
           }
       } catch {
           activityIndicator.stopAnimating()
           showError(message: "Error adding appointment: \(error.localizedDescription)")
       }
    }
    
    private func getCellTextFieldText(indexPath: IndexPath) -> String? {
        guard let cell = tableView.cellForRow(at: indexPath) as? NutritionTableViewCell else {
            return nil
        }
        return cell.rightTextField.text
    }
    
    private func setupErrorLabel() {
        errorField.translatesAutoresizingMaskIntoConstraints = false
    }

    private func showError(message: String) {
        errorField.text = message
        errorField.isHidden = false
    }

    private func hideError() {
        errorField.text = nil
        errorField.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NutritionTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.leftLabel.text = "Title"
            cell.rightTextField.placeholder = "title"
            cell.rightTextField.textAlignment = .center
            cell.rightTextField.autocorrectionType = .no
            cell.rightTextField.autocapitalizationType = .none
        case 1:
            cell.leftLabel.text = "Doctor"
            cell.rightTextField.placeholder = "doctor"
            cell.rightTextField.textAlignment = .center
            cell.rightTextField.autocorrectionType = .no
            cell.rightTextField.autocapitalizationType = .none
        case 2:
            cell.leftLabel.text = "Date"
            cell.rightTextField.placeholder = "dd/mm/year"
            cell.rightTextField.textAlignment = .center
            cell.rightTextField.autocorrectionType = .no
            cell.rightTextField.autocapitalizationType = .none
        case 3:
            cell.leftLabel.text = "Place"
            cell.rightTextField.placeholder = "address"
            cell.rightTextField.textAlignment = .center
            cell.rightTextField.autocorrectionType = .no
            cell.rightTextField.autocapitalizationType = .none
        default:
            break
        }

        return cell
    }
    
    
}

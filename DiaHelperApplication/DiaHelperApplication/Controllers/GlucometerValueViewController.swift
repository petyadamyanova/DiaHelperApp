//
//  GlucometerValueViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 15.12.23.
//

import UIKit

protocol GlucometerValueViewControllerDelegate: AnyObject {
    func didSubmitGlucometerTest(_ value: Double)
}

class GlucometerValueViewController: UIViewController, UITextFieldDelegate {
    weak var delegate: GlucometerValueViewControllerDelegate?
    private let tableView = UITableView()
    private let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDismissButton()
        setupTableView()
        setupSubmitButton()
        setupErrorLabel()
        view.backgroundColor = .systemGray6
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    public var errorField: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Error"
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        self.tableView.layer.borderColor = UIColor.systemGray6.cgColor
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.cornerRadius = 10;
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16 + (44 * 2 ))
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
        
        view.addSubview(submitButton)

        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16 + 16),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        
        let submitAction = UIAction(handler: didtapSubmitButton)
        submitButton.addAction(submitAction, for: .touchUpInside)
    }
    
    private func didtapSubmitButton(_ action: UIAction) {
        var timestamp: Date = Date()
        var bloodSugar: Double = 0.0
        
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            switch indexPath.row {
            case 0:
                if let text = getCellTextFieldText(indexPath: indexPath) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    if let date = dateFormatter.date(from: text) {
                        timestamp = date
                        hideError()
                    } else {
                        showError(message: "Time has to be in HH:mm format")
                        return
                    }
                }
            case 1:
                if let text = getCellTextFieldText(indexPath: indexPath), let glucose1 = Double(text), glucose1 >= 2 && glucose1 <= 30 {
                    bloodSugar = glucose1
                    hideError()
                } else {
                    showError(message: "Invalid input for blood sugar. Has to be between 2 and 30.")
                    return
                }
            default:
                break
            }
        }
        
        let glucometerBloodSugarTest = GlucometerBloodSugarTest(timestamp: timestamp, bloodSugar: bloodSugar)
        
        UserManager.shared.addGlucometerBloodSugarTest(glucometerBloodSugarTest)
        
        //print(UserManager.shared.getAllGlucometerBloodSugarTests())
        delegate?.didSubmitGlucometerTest(glucometerBloodSugarTest.bloodSugar)
        
        dismiss(animated: true)
    }
    
    private func getCellTextFieldText(indexPath: IndexPath) -> String? {
        guard let cell = tableView.cellForRow(at: indexPath) as? NutritionTableViewCell else {
            return nil
        }
        return cell.rightTextField.text
    }
    
    private func setupErrorLabel() {
        view.addSubview(errorField)

        errorField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            errorField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            errorField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
        ])
    }

    private func showError(message: String) {
        errorField.text = message
        errorField.isHidden = false
    }

    private func hideError() {
        errorField.text = nil
        errorField.isHidden = true
    }
}

extension GlucometerValueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NutritionTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.leftLabel.text = "Time"
            cell.rightTextField.placeholder = getCurrentTime()
            cell.rightTextField.delegate = self
        case 1:
            cell.leftLabel.text = "Enter blood sugar 🩸"
            cell.rightTextField.placeholder = "Enter Value"
            cell.rightTextField.keyboardType = .numberPad
            cell.rightTextField.textAlignment = .center
        default:
            break
        }

        return cell
    }
}

extension GlucometerValueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let indexPath = indexPathForTextField(textField) {
            switch indexPath.row {
            case 0:
                let currentTime = getCurrentTime()
                textField.text = currentTime
                textField.textAlignment = .center
            default:
                break
            }
        }
    }

    private func indexPathForTextField(_ textField: UITextField) -> IndexPath? {
        let point = textField.convert(CGPoint.zero, to: tableView)
        return tableView.indexPathForRow(at: point)
    }
    
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
}

//
//  RegisterDataViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 26.11.23.
//

import UIKit

class RegistrationDataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var nigscout: String = ""
    var birtDate: String = ""
    var yearOfDiagnosis: String = ""
    var pumpModel: PumpModel = .None
    var sensorModel: SensorModel = .None
    
    private lazy var pumpPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    private lazy var sensorPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupDismissButton()
        setupSubmitButton()
        addSubviews()
        addStackViewConstraints()

        pumpPickerView.delegate = self
        pumpPickerView.dataSource = self

        sensorPickerView.delegate = self
        sensorPickerView.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pumpPickerView {
            return PumpModel.allCases.count
        } else if pickerView == sensorPickerView {
            return SensorModel.allCases.count
        } else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pumpPickerView {
            return PumpModel.allCases[row].rawValue
        } else if pickerView == sensorPickerView {
            return SensorModel.allCases[row].rawValue
        } else {
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pumpPickerView {
            pumpModel = PumpModel.allCases[row]
        } else if pickerView == sensorPickerView {
            sensorModel = SensorModel.allCases[row]
        }
    }
    
    private var nightscoutField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Nightscout"
        txtField.textField.placeholder = "Enter Nightscout"
        txtField.textField.isSecureTextEntry = true
        return txtField
    }()

    private var birtDateField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Birthdate"
        txtField.textField.placeholder = "Enter birthdate"
        txtField.textField.isSecureTextEntry = true
        return txtField
    }()
    
    private var yearOfDiagnosisField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Year of diagnosis"
        txtField.textField.placeholder = "Enter the Year of diagnosis"
        txtField.textField.isSecureTextEntry = true
        return txtField
    }()
    
    private lazy var pumpPickerTextField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Pump Model"
        txtField.textField.placeholder = " Select Pump Model"
        txtField.textField.isSecureTextEntry = true
        txtField.textField.textAlignment = .left
        txtField.textField.inputView = pumpPickerView
        txtField.textField.isSecureTextEntry = true
    
        return txtField
    }()
    
    private lazy var sensorPickerTextField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Sensor Model"
        txtField.textField.placeholder = " Select sensor model"
        txtField.textField.isSecureTextEntry = true
        txtField.textField.textAlignment = .left
        txtField.textField.inputView = sensorPickerView
    
        return txtField
    }()

    private func setupSubmitButton() {
        let submitAction = UIAction(handler: didTapSubmitButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", primaryAction: submitAction)
    }

    private func didTapSubmitButton(_ action: UIAction) {
        let mainTabBarViewController = MainTabBarViewController()
        let navController = UINavigationController(rootViewController: mainTabBarViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }

    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }

    private func addSubviews() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(nightscoutField)
        stackView.addArrangedSubview(birtDateField)
        stackView.addArrangedSubview(yearOfDiagnosisField)
        stackView.addArrangedSubview(pumpPickerTextField)
        stackView.addArrangedSubview(sensorPickerTextField)
    }

    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
}

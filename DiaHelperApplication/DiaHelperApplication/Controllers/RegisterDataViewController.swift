//
//  RegisterDataViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 26.11.23.
//

import UIKit

class RegistrationDataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var name: String = ""
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var password2: String = ""

    
    var nigscout: String = ""
    var birtDate: String = ""
    var yearOfDiagnosis: String = ""
    var pumpModel: PumpModel = .None
    var sensorModel: SensorModel = .None
    var insulinType: InsulinType = .Other
    
    private let birthDateValidator = BirthDateValidator()
    private let yearOfDiagnosisValidator = YearOfDiagnosisValidator()
    
    private lazy var pumpPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    private lazy var sensorPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private lazy var insulinPickerView: UIPickerView = {
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
        
        insulinPickerView.delegate = self
        insulinPickerView.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pumpPickerView {
            return PumpModel.allCases.count
        } else if pickerView == sensorPickerView {
            return SensorModel.allCases.count
        } else if pickerView == insulinPickerView {
            return InsulinType.allCases.count
        } else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pumpPickerView {
            return PumpModel.allCases[row].rawValue
        } else if pickerView == sensorPickerView {
            return SensorModel.allCases[row].rawValue
        } else if pickerView == insulinPickerView {
            return InsulinType.allCases[row].rawValue
        }else {
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pumpPickerView {
            pumpPickerTextField.textField.text = PumpModel.allCases[row].rawValue
            pumpModel = PumpModel.allCases[row]
        } else if pickerView == sensorPickerView {
            sensorPickerTextField.textField.text = SensorModel.allCases[row].rawValue
            sensorModel = SensorModel.allCases[row]
        } else if pickerView == insulinPickerView {
            insulinPickerTextField.textField.text = InsulinType.allCases[row].rawValue
            insulinType = InsulinType.allCases[row]
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        birthDateField.textField.text = dateFormatter.string(from: sender.date)
    }
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to DiaHelper app! You have to set your personal data here: "
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private var nightscoutField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Nightscout"
        txtField.textField.placeholder = "Enter Nightscout"
        return txtField
    }()
    
    private lazy var birthDateField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Birthdate"
        txtField.textField.placeholder = "Select birthdate"
        txtField.textField.textAlignment = .left
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        txtField.textField.inputView = datePicker
        
        return txtField
    }()

    private var yearOfDiagnosisField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Year of diagnosis"
        txtField.textField.placeholder = "Enter the Year of diagnosis"
        return txtField
    }()
    
    private lazy var pumpPickerTextField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Pump Model"
        txtField.textField.placeholder = " Select Pump Model"
        txtField.textField.textAlignment = .left
        txtField.textField.inputView = pumpPickerView
    
        return txtField
    }()
    
    private lazy var sensorPickerTextField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Sensor Model"
        txtField.textField.placeholder = " Select sensor model"
        txtField.textField.textAlignment = .left
        txtField.textField.inputView = sensorPickerView
    
        return txtField
    }()
    
    private lazy var insulinPickerTextField: TextInput2 = {
        let txtField = TextInput2()
        txtField.label.text = "Insulin type"
        txtField.textField.placeholder = " Select insulin type"
        txtField.textField.textAlignment = .left
        txtField.textField.inputView = insulinPickerView
    
        return txtField
    }()
    
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .red
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private func setupSubmitButton() {
        let submitAction = UIAction(handler: didTapSubmitButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", primaryAction: submitAction)
    }
    
    private func didTapSubmitButton(_ action: UIAction) {
        guard var nightscout = nightscoutField.textField.text,
                  let birthDate = birthDateField.textField.text,
                  let yearOfDiagnosis = yearOfDiagnosisField.textField.text else {
                      return
                  }
        
        if !birthDateValidator.isValid(birthDate) {
            showError(message: "Birthday is not valid!")
            return
        }
        
        if !yearOfDiagnosisValidator.isValid(yearOfDiagnosis, birthDate) {
            showError(message: "Year of diagnosis is not valid!")
            return
        }
        
        if nightscout.isEmpty {
            nightscout = "none"
        }

        errorLabel.isHidden = true
        
        let api = RegisterUserAPI()
        api.registerUser(name: name, email: email, username: username, password: password, password2: password2, nightscout: nightscout, birtDate: birthDate, yearOfDiagnosis: yearOfDiagnosis, pumpModel: pumpModel.rawValue, sensorModel: sensorModel.rawValue, insulinType: insulinType.rawValue)
        
        let loginUserAPI = LoginUserAPI()
        loginUserAPI.loginUser(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    // Login successful
                    let mainTabBarViewController = MainTabBarViewController()
                    let navController = UINavigationController(rootViewController: mainTabBarViewController)
                    navController.modalPresentationStyle = .fullScreen
                    self.navigationController?.setViewControllers([mainTabBarViewController], animated: true)

                case .failure(let error):
                    // Handle login failure
                    switch error {
                    case NetworkError.userNotFound:
                       print("error: User not found")
                    default:
                        print("error")
                    }
                }
            }
        }
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

        //stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(birthDateField)
        stackView.addArrangedSubview(yearOfDiagnosisField)
        stackView.addArrangedSubview(pumpPickerTextField)
        stackView.addArrangedSubview(sensorPickerTextField)
        stackView.addArrangedSubview(insulinPickerTextField)
        stackView.addArrangedSubview(nightscoutField)
        stackView.addArrangedSubview(errorLabel)
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
    
    private func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}

//
//  EditProfileViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.02.24.
//

import Foundation
import UIKit

protocol EditProfileViewControllerDelegate: AnyObject {
    func setTimer(_ newNightscout: String)
}

class EditProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    weak var delegate: EditProfileDelegate?
    weak var homeViewController: HomeViewController?
    private let emailValidator = EmailValidator()
    private let yearOfDiagnosisValidator = YearOfDiagnosisValidator()
    var pumpModel = UserManager.shared.getCurrentUser()?.pumpModel
    var sensorModel = UserManager.shared.getCurrentUser()?.sensorModel
    var insulinType = UserManager.shared.getCurrentUser()?.insulinType
    
    internal var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        setupSubmitButton()
        addSubviews()
        addConstraints()
        
        pumpPickerView.delegate = self
        pumpPickerView.dataSource = self

        sensorPickerView.delegate = self
        sensorPickerView.dataSource = self
        
        insulinPickerView.delegate = self
        insulinPickerView.dataSource = self
    }
    
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
        DispatchQueue.main.async { [self] in
            if pickerView == pumpPickerView {
                pumpField.textField.text = PumpModel.allCases[row].rawValue
                pumpModel = PumpModel.allCases[row]
            } else if pickerView == sensorPickerView {
                sensorField.textField.text = SensorModel.allCases[row].rawValue
                sensorModel = SensorModel.allCases[row]
            } else if pickerView == insulinPickerView {
                insulinField.textField.text = InsulinType.allCases[row].rawValue
                insulinType = InsulinType.allCases[row]
            }
        }
    }
    
    private var usernameField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Username"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.username ?? "")"
        return textField
    }()
    
    private var emailField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Email"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.email ?? "")"
        return textField
    }()
    
    private var nightscoutField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Nightscout"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.nightscout ?? "")"
        return textField
    }()
    
    private var birthDateField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Birthdate"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.birtDate ?? "")"
        return textField
    }()
    
    private var yearOfDiagnosisField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Year of diagnosis"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.yearOfDiagnosis ?? "")"
        return textField
    }()
    
    private lazy var pumpField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Pump Model"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.pumpModel.rawValue ?? "")"
        textField.textField.inputView = pumpPickerView
        return textField
    }()
    
    private lazy var sensorField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Sensor Model"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.sensorModel.rawValue ?? "")"
        textField.textField.inputView = sensorPickerView
        return textField
    }()
    
    private lazy var insulinField: RoundedValidatedTextInput = {
        let textField = RoundedValidatedTextInput()
        textField.label.text = "Insulin Type"
        textField.textField.placeholder = " \(UserManager.shared.getCurrentUser()?.insulinType.rawValue ?? "")"
        textField.textField.inputView = insulinPickerView
        return textField
    }()
    
    public var submitButton: UIButton = {
        let color = UIColor(named: "newBlue")
        
        let button = UIButton(type: .system)
        button.setTitle("submit", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private func setupSubmitButton() {
        let action = UIAction(handler: submitButtonTapped)
        submitButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func submitButtonTapped(_ action: UIAction) {
        let userIdString = UserManager.shared.getCurrentUserId()
        let userId = UUID(uuidString: userIdString)
        let updateUserInfoAPI = UpdateUserInfoAPI.shared
        
        if usernameField.textField.text?.isEmpty == false {
            let newUsername = usernameField.textField.text
            
            updateUserInfoAPI.updateUsername(userId: userId!.uuidString, newUsername: newUsername!) { error in
                if let error = error {
                    // Handle the error
                    print("Error updating username: \(error)")
                } else {
                    // Username updated successfully
                    print("Username updated successfully")
                    self.delegate?.didUpdateUsername(newUsername!)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        if emailField.textField.text?.isEmpty == false {
            let newEmail = emailField.textField.text
            
            if !emailValidator.isValid(newEmail!) {
                showErrorForField(field: emailField, message: "Invalid email format")
                return
            } else {
                removeErrorForField(field: emailField)
            }
            
            updateUserInfoAPI.updateEmail(userId: userId!.uuidString, newEmail: newEmail!) { error in
                if let error = error {
                    print("Error updating username: \(error)")
                } else {
                    self.delegate?.didUpdateEmail(newEmail!)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        if nightscoutField.textField.text?.isEmpty == false {
            let newNightscout = nightscoutField.textField.text
            
            updateUserInfoAPI.updateNightscout(userId: userId!.uuidString, newNightscout: newNightscout!) { error in
                if let error = error {
                    print("Error updating username: \(error)")
                } else {
                    self.delegate?.didUpdateNightscout(newNightscout!)
                    self.homeViewController?.setTimer(newNightscout!)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        if pumpModel?.rawValue.isEmpty == false {
            let newPumpModel = pumpModel!.rawValue
            
            updateUserInfoAPI.updatePumpModel(userId: userId!.uuidString, newPumpModel: newPumpModel) { error in
                if let error = error {
                    print("Error updating username: \(error)")
                } else {
                    self.delegate?.didUpdatePumpModel(newPumpModel)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        if sensorModel?.rawValue.isEmpty == false {
            let newSensorModel = sensorModel!.rawValue
            
            updateUserInfoAPI.updateSensorModel(userId: userId!.uuidString, newSensorModel: newSensorModel) { error in
                if let error = error {
                    print("Error updating username: \(error)")
                } else {
                    self.delegate?.didUpdateSensorModel(newSensorModel)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        if insulinType?.rawValue.isEmpty == false {
            let newInsulinType = insulinType!.rawValue
            
            updateUserInfoAPI.updateInsulinType(userId: userId!.uuidString, newInsulinType: newInsulinType) { error in
                if let error = error {
                    print("Error updating username: \(error)")
                } else {
                    self.delegate?.didUpdateInsulinType(newInsulinType)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        
        
        if let newBirthDateString = birthDateField.textField.text, !newBirthDateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            if dateFormatter.date(from: newBirthDateString) != nil {

                updateUserInfoAPI.updateBirthDate(userId: userId!.uuidString, newBirthDate: newBirthDateString) { error in
                    if let error = error {
                        print("Error updating birth date: \(error)")
                    } else {
                        self.delegate?.didUpdateBirthDate(newBirthDateString)
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                            self.removeErrorForField(field: self.birthDateField)
                        }
                    }
                }
            } else {
                showErrorForField(field: birthDateField, message: "Invalid date format. Please use dd/MM/yyyy.")
                return
                
            }
        }
        
        if let newYearOfDiagnosisString = yearOfDiagnosisField.textField.text, !newYearOfDiagnosisString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"

            if dateFormatter.date(from: newYearOfDiagnosisString) != nil {

                updateUserInfoAPI.updateYearOfDiagnosis(userId: userId!.uuidString, newYearOfDiagnosis: newYearOfDiagnosisString) { error in
                    if let error = error {
                        print("Error updating birth date: \(error)")
                    } else {
                        self.delegate?.didUpdateYearOfDiagnosis(newYearOfDiagnosisString)
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                            self.removeErrorForField(field: self.yearOfDiagnosisField)
                        }
                    }
                }
            } else {
                showErrorForField(field: yearOfDiagnosisField, message: "Invalid date format. Please use yyyy.")
                return
                
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(nightscoutField)
        stackView.addArrangedSubview(birthDateField)
        stackView.addArrangedSubview(yearOfDiagnosisField)
        stackView.addArrangedSubview(pumpField)
        stackView.addArrangedSubview(sensorField)
        stackView.addArrangedSubview(insulinField)
        stackView.addArrangedSubview(submitButton)
    }
    
    private func addConstraints(){
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    private func showErrorForField(field: RoundedValidatedTextInput, message: String) {
        field.errorField.isHidden = false
        field.errorField.textColor = UIColor.systemRed
        field.errorField.text = message
    }
    
    private func removeErrorForField(field: RoundedValidatedTextInput) {
        field.errorField.isHidden = true
        field.textField.layer.borderColor = UIColor(named: "newBrown")?.cgColor ?? UIColor.lightGray.cgColor
        field.textField.layer.cornerRadius = 8
        field.textField.layer.borderWidth = 1
    }
    
}

protocol EditProfileDelegate: AnyObject {
    func didUpdateUsername(_ newUsername: String)
    func didUpdateEmail(_ newEmail: String)
    func didUpdateNightscout(_ newNightscout: String)
    func didUpdateBirthDate(_ newBirthDate: String)
    func didUpdateYearOfDiagnosis(_ newYearOfDiagnosis: String)
    func didUpdatePumpModel(_ newPumpModel: String)
    func didUpdateSensorModel(_ newSensorModel: String)
    func didUpdateInsulinType(_ newInsulintype: String)
}



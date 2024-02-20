//
//  EditProfileViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.02.24.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController {
    weak var delegate: EditProfileDelegate?
    private let emailValidator = EmailValidator()
    
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
        
        if usernameField.textField.text?.isEmpty == false {
            let newUsername = usernameField.textField.text
            let updateUsernameAPI = UpdateUsernameAPI.shared
            
            updateUsernameAPI.updateUsername(userId: userId!.uuidString, newUsername: newUsername!) { error in
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
            let updateEmailAPI = UpdateEmailAPI.shared
            
            if !emailValidator.isValid(newEmail!) {
                showErrorForField(field: emailField, message: "Invalid email format")
                return
            } else {
                removeErrorForField(field: emailField)
            }
            
            updateEmailAPI.updateEmail(userId: userId!.uuidString, newEmail: newEmail!) { error in
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
            let updateNightscoutAPI = UpdateNightscoutAPI.shared
            
            updateNightscoutAPI.updateNightscout(userId: userId!.uuidString, newNightscout: newNightscout!) { error in
                if let error = error {
                    print("Error updating username: \(error)")
                } else {
                    self.delegate?.didUpdateNightscout(newNightscout!)
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
                let updateBirthDateAPI = UpdateBirthDateAPI.shared

                updateBirthDateAPI.updateBirthDate(userId: userId!.uuidString, newBirthDate: newBirthDateString) { error in
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
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(nightscoutField)
        stackView.addArrangedSubview(birthDateField)
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
}



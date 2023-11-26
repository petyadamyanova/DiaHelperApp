//
//  LoginViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupDismissButton()
        setupLoginButton()
        addSubviews()
        addStackViewConstraints()
    }

    private let emailValidator = EmailValidator()
    private let passwordValidator = PasswordValidator()

    internal var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    internal var emailField: RoundedValidatedTextInput = {
        let txtField = RoundedValidatedTextInput()
        txtField.label.text = "Email"
        txtField.textField.placeholder = " Enter email"

        return txtField
    }()

    internal var passwordField: RoundedValidatedTextInput = {
        let txtField = RoundedValidatedTextInput()
        txtField.label.text = "Password"
        txtField.textField.placeholder = " Enter password"
        txtField.textField.isSecureTextEntry = true

        return txtField
    }()

    internal var loginButton: UIButton = {
        let button = UIButton()
        let color = UIColor(named: "newBrown")
        button.setTitle("Login", for: .normal)

        button.setTitleColor(color, for: .normal)
        button.tintColor = UIColor(named: "newBlue")

        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        button.configuration = buttonConfiguration

        return button
    }()

    private func setupLoginButton() {
        let loginAction = UIAction(handler: didTapLoginButton)
        loginButton.addAction(loginAction, for: .touchUpInside)
    }

    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }

    private func addSubviews() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(loginButton)
    }

    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    private func didTapLoginButton(_ action: UIAction) {
        guard let email = emailField.textField.text,
              let password = passwordField.textField.text else {
            return
        }
        
        //proverka - dali sa validni
        
        let mainTabBarViewController = MainTabBarViewController()
        let navController = UINavigationController(rootViewController: mainTabBarViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
                
    }
}


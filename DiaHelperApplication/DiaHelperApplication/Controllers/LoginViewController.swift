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
        setupSignUpLabel()
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
        txtField.label.text = " Email"
        txtField.textField.placeholder = " Enter email"

        return txtField
    }()

    internal var passwordField: RoundedValidatedTextInput = {
        let txtField = RoundedValidatedTextInput()
        txtField.label.text = " Password"
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
    
    private var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? Sign up"
        label.textColor = UIColor(named: "newBrown")
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private func setupSignUpLabel() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSignUpLabel))
        signUpLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
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
    
    @objc private func didTapSignUpLabel() {
        let registerViewController = RegisterViewController()
        let navController = UINavigationController(rootViewController: registerViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }

    private func addSubviews() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpLabel)
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

        let loginUserAPI = LoginUserAPI()
        loginUserAPI.loginUser(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    // Login successful
                    let mainTabBarViewController = MainTabBarViewController()
                    let navController = UINavigationController(rootViewController: mainTabBarViewController)
                    navController.modalPresentationStyle = .fullScreen
                    self.navigationController?.setViewControllers([mainTabBarViewController], animated: true)

                case .failure(let error):
                    // Handle login failure
                    switch error {
                    case NetworkError.userNotFound:
                        self.showErrorForField(field: self.emailField, message: "Incorrect email")
                    default:
                        self.showErrorForField(field: self.emailField, message: "Incorrect email or password")
                    }
                    // Optionally, display an error message to the user
                    print("Error during login: \(error)")
                }
            }
        }
    }

    
    private func showErrorForField(field: RoundedValidatedTextInput, message: String) {
        field.errorField.isHidden = false
        field.errorField.textColor = UIColor.systemRed
        field.errorField.text = message
    }
    
    private func removeErrorForField(field: RoundedValidatedTextInput) {
        field.errorField.isHidden = true
        field.textField.layer.borderColor = UIColor.black.cgColor
        field.textField.layer.cornerRadius = 6
        field.textField.layer.borderWidth = 2
    }
}


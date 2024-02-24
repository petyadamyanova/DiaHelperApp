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
    
    private var activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView(style: .medium)
       indicator.hidesWhenStopped = true
       return indicator
    }()
    
    private func setupLoginButton() {
        let loginAction = UIAction { [weak self] action in
            Task {
                await self?.didTapLoginButton(action)
            }
        }
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
        stackView.addArrangedSubview(activityIndicator)
    }

    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    private func didTapLoginButton(_ action: UIAction) async {
        guard let email = emailField.textField.text,
              let password = passwordField.textField.text else {
            return
        }
        
        activityIndicator.startAnimating()
        
        do {
            let newUser = try await LoginUserAPI().loginUser(email: email, password: password)
            
            activityIndicator.stopAnimating()
            // Login successful
            let mainTabBarViewController = MainTabBarViewController()
            let navController = UINavigationController(rootViewController: mainTabBarViewController)
            navController.modalPresentationStyle = .fullScreen
            navigationController?.setViewControllers([mainTabBarViewController], animated: true)
            
        } catch let loginError as LoginError {
            // Проверка за специфичните грешки
            switch loginError {
            case .userNotFound:
                showErrorForField(field: emailField, message: "Incorrect email")
            case .invalidPassword:
                showErrorForField(field: passwordField, message: "Incorrect password")
            case .invalidEmailOrPassword:
                showErrorForField(field: emailField, message: "Incorrect email or password")
            }
            activityIndicator.stopAnimating()
            return
        } catch {
            showErrorForField(field: emailField, message: "Unexpected error. Try again")
            activityIndicator.stopAnimating()
            return
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


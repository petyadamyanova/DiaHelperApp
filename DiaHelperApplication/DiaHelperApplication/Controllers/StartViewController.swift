//
//  StartViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.11.23.
//

import UIKit

class StartViewController: UIViewController {
    private var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 14
        return stackView
    }()
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to DiaHelper!"
        label.textAlignment = .center
        label.textColor = UIColor(named: "newBlue")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var loginButton = {
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
    
    private var registerButton = {
        let button = UIButton()
        let color = UIColor(named: "newBrown")
        button.setTitle("Register", for: .normal)
        
        button.setTitleColor(color, for: .normal)
        button.tintColor = UIColor(named: "newBlue")
        
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "startView")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")

        setupLoginButton()
        setupRegisterButton()
        addSubviews()
        addStackViewConstraints()
    }
    
    private func setupRegisterButton() {
        let registerAction = UIAction(handler: didtapRegisterButton)
        registerButton.addAction(registerAction, for: .touchUpInside)
    }
    
    private func didtapRegisterButton(_ action: UIAction) {
        let registerViewController = RegisterViewController()
        let navController = UINavigationController(rootViewController: registerViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    private func setupLoginButton() {
        let loginAction = UIAction(handler: didtapLoginButton)
        loginButton.addAction(loginAction, for: .touchUpInside)
    }
    
    private func didtapLoginButton(_ action: UIAction) {
        let loginViewController = LoginViewController()
        let navController = UINavigationController(rootViewController: loginViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
    }
    
    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}




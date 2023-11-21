//
//  ProfileViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class ProfileViewController: UIViewController {
    weak var delegate: ProfileViewControllerDelegate?
    
    internal var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    public var nightscoutField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 35))
        return textField
    }()
    
    private var submitButton = {
        let button = UIButton()
        let color = UIColor(named: "newBrown")
        button.setTitle("Submit", for: .normal)
        
        button.setTitleColor(color, for: .normal)
        button.tintColor = UIColor(named: "newBlue")
        
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private func setupSubmitButton() {
        let action = UIAction(handler: didtapSubmitButton)
        submitButton.addAction(action, for: .touchUpInside)
    }
    
    private func didtapSubmitButton(_ action: UIAction) {
        if let nightscoutURL = nightscoutField.text {
            //print(nightscoutURL)
            delegate?.didSubmitNightscoutURL(nightscoutURL)
        }
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(nightscoutField)
        stackView.addArrangedSubview(submitButton)
    }
    
    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupSubmitButton()
        addSubviews()
        addStackViewConstraints()
    }

}

protocol ProfileViewControllerDelegate: AnyObject {
    func didSubmitNightscoutURL(_ nightscoutURL: String)
}

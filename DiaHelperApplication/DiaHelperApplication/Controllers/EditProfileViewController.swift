//
//  EditProfileViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.02.24.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
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
    
    private func setupEditButton() {
        let action = UIAction(handler: submitButtonTapped)
        submitButton.addAction(action, for: .touchUpInside)
    }
    
    private func submitButtonTapped(_ action: UIAction) {
        dismiss(animated: true)
    }
    
}

//
//  RegisterViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupDismissButton()
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }
    
    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }

}

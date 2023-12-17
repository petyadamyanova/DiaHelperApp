//
//  GlucometerValueViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 15.12.23.
//

import UIKit

class GlucometerValueViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDismissButton()
        view.backgroundColor = .systemGray6
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
}

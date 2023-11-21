//
//  AddNutritionViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 21.11.23.
//

import UIKit

class AddNutritionViewController: UIViewController {

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

}

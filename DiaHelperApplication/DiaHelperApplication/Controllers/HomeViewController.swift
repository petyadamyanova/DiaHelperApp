//
//  HomeViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        setupLoginButton()
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
    }

    
    private func setupLoginButton() {
        let loginAction = UIAction(title: "Login", handler: didTapLogin)
        navigationItem.leftBarButtonItem = UIBarButtonItem(primaryAction: loginAction)
    }
    
    private func didTapLogin(_ action: UIAction) {
        let logInViewController = LoginViewController()
        let navController = UINavigationController(rootViewController: logInViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }
}

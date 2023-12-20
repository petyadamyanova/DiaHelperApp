//
//  ProfileViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class ProfileViewController: UIViewController {
    var currentUser: User?
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileSettingsIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emailIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var nightscoutIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nightscoutIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        if let user = UserManager.shared.getCurrentUser() {
            currentUser = user
        }
        
        setUpNameLabel()
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(emailIcon)
        view.addSubview(nightscoutIcon)
    }
    
    private func addConstraints() {
        view.addConstraints([
            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            usernameLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
            emailIcon.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            emailIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            emailIcon.heightAnchor.constraint(equalToConstant: 30),
            emailIcon.widthAnchor.constraint(equalToConstant: 30),
            
            nightscoutIcon.topAnchor.constraint(equalTo: emailIcon.bottomAnchor, constant: 12),
            nightscoutIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nightscoutIcon.heightAnchor.constraint(equalToConstant: 30),
            nightscoutIcon.widthAnchor.constraint(equalToConstant: 30)
    
        ])
    }
    
    private func setUpNameLabel(){
        nameLabel.text = currentUser?.name
        usernameLabel.text = currentUser?.username
    }
    
    
}



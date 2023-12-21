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
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var nightscoutIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nightscoutIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var nightscoutTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var birthDateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "birthDateIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var yearOfDiagnosisIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yearOfDiagnosisIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var yearOfDiagnosisTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var pumpIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pumpIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var pumpTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var sensorIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sensorIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var sensorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        if let user = UserManager.shared.getCurrentUser() {
            currentUser = user
        }
        
        setUpNameLabel()
        setupEmailTextField()
        setupNightscoutTextField()
        setupBirthDateTextField()
        setupYearOfDiagnosisTextField()
        setupPumpTextField()
        setupSensorTextField()
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(emailIcon)
        view.addSubview(emailTextField)
        view.addSubview(nightscoutIcon)
        view.addSubview(nightscoutTextField)
        view.addSubview(birthDateIcon)
        view.addSubview(birthDateTextField)
        view.addSubview(yearOfDiagnosisIcon)
        view.addSubview(yearOfDiagnosisTextField)
        view.addSubview(pumpIcon)
        view.addSubview(pumpTextField)
        view.addSubview(sensorIcon)
        view.addSubview(sensorTextField)
        
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
            
            emailTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: 16),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            nightscoutIcon.topAnchor.constraint(equalTo: emailIcon.bottomAnchor, constant: 12),
            nightscoutIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nightscoutIcon.heightAnchor.constraint(equalToConstant: 30),
            nightscoutIcon.widthAnchor.constraint(equalToConstant: 30),
            
            nightscoutTextField.topAnchor.constraint(equalTo: emailIcon.bottomAnchor, constant: 12),
            nightscoutTextField.leadingAnchor.constraint(equalTo: nightscoutIcon.trailingAnchor, constant: 16),
            nightscoutTextField.heightAnchor.constraint(equalToConstant: 30),
            
            birthDateIcon.topAnchor.constraint(equalTo: nightscoutIcon.bottomAnchor, constant: 12),
            birthDateIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            birthDateIcon.heightAnchor.constraint(equalToConstant: 30),
            birthDateIcon.widthAnchor.constraint(equalToConstant: 30),
            
            birthDateTextField.topAnchor.constraint(equalTo: nightscoutIcon.bottomAnchor, constant: 12),
            birthDateTextField.leadingAnchor.constraint(equalTo: birthDateIcon.trailingAnchor, constant: 16),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 30),
            
            yearOfDiagnosisIcon.topAnchor.constraint(equalTo: birthDateIcon.bottomAnchor, constant: 12),
            yearOfDiagnosisIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 34),
            yearOfDiagnosisIcon.heightAnchor.constraint(equalToConstant: 30),
            yearOfDiagnosisIcon.widthAnchor.constraint(equalToConstant: 30),
            
            yearOfDiagnosisTextField.topAnchor.constraint(equalTo: birthDateIcon.bottomAnchor, constant: 12),
            yearOfDiagnosisTextField.leadingAnchor.constraint(equalTo: yearOfDiagnosisIcon.trailingAnchor, constant: 16),
            yearOfDiagnosisTextField.heightAnchor.constraint(equalToConstant: 30),
            
            pumpIcon.topAnchor.constraint(equalTo: yearOfDiagnosisIcon.bottomAnchor, constant: 12),
            pumpIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            pumpIcon.heightAnchor.constraint(equalToConstant: 30),
            pumpIcon.widthAnchor.constraint(equalToConstant: 30),
            
            pumpTextField.topAnchor.constraint(equalTo: yearOfDiagnosisIcon.bottomAnchor, constant: 12),
            pumpTextField.leadingAnchor.constraint(equalTo: pumpIcon.trailingAnchor, constant: 16),
            pumpTextField.heightAnchor.constraint(equalToConstant: 30),
            
            sensorIcon.topAnchor.constraint(equalTo: pumpIcon.bottomAnchor, constant: 12),
            sensorIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            sensorIcon.heightAnchor.constraint(equalToConstant: 30),
            sensorIcon.widthAnchor.constraint(equalToConstant: 30),
            
            sensorTextField.topAnchor.constraint(equalTo: pumpIcon.bottomAnchor, constant: 12),
            sensorTextField.leadingAnchor.constraint(equalTo: sensorIcon.trailingAnchor, constant: 16),
            sensorTextField.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    private func setUpNameLabel(){
        nameLabel.text = currentUser?.name
        usernameLabel.text = currentUser?.username
    }
    
    private func setupEmailTextField(){
        emailTextField.text = currentUser?.email
    }
    
    private func setupNightscoutTextField(){
        nightscoutTextField.text = currentUser?.nightscout
    }
    
    private func setupBirthDateTextField(){
        birthDateTextField.text = currentUser?.birtDate
    }
    
    private func setupYearOfDiagnosisTextField(){
        yearOfDiagnosisTextField.text = currentUser?.yearOfDiagnosis
    }
    
    private func setupPumpTextField(){
        pumpTextField.text = currentUser?.pumpModel.rawValue
    }
    
    private func setupSensorTextField(){
        sensorTextField.text = currentUser?.sensorModel.rawValue
    }
    
}



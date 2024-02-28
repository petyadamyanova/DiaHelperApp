//
//  ProtocolsReminder.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 20.01.24.
//

import UIKit

class ProtocolsReminderViewController: UIViewController {
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        createInsulinDatePicker()
        createPumpSetDatePicker()
        createSensorDatePicker()
        addSubviews()
        addStackViewConstraints()
    }
    
    internal var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    internal var insulinProtocolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    internal var pumpProtocolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    internal var sensorProtocolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    let insulinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "InsulinProtocolIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let pumpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pumpSetIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let sensorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sensorProtocolIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var insulinField: InsulinCanulaReminderField = {
        let field = InsulinCanulaReminderField()
        field.nameLabel.text = "Insulin protocol"
        field.startLabel.text = "Last take:"
        field.startLabel.widthAnchor.constraint(equalToConstant: 97).isActive = true
        field.startDateField.placeholder = "Enter date"

        return field
    }()
    
    lazy var pumpField: InsulinCanulaReminderField = {
        let field = InsulinCanulaReminderField()
        field.nameLabel.text = "Pump set protocol"
        field.startLabel.text = "Last take:"
        field.startLabel.widthAnchor.constraint(equalToConstant: 97).isActive = true
        field.startDateField.placeholder = "Enter date"

        return field
    }()
    
    lazy var sensorField: InsulinCanulaReminderField = {
        let field = InsulinCanulaReminderField()
        field.nameLabel.text = "Sensor protocol"
        field.startLabel.text = "Last take:"
        field.startLabel.widthAnchor.constraint(equalToConstant: 97).isActive = true
        field.startDateField.placeholder = "Enter date"

        return field
    }()
    
    public var reminderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Baskerville", size: 40)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Protocols"
        label.textAlignment = .center
        label.textColor = UIColor(named: "newBlue")
        
        return label
    }()
    
    func createInsulinDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneInsulinPressed))
        toolbar.setItems([doneButton], animated: true)
        insulinField.startDateField.inputAccessoryView = toolbar
        insulinField.startDateField.inputView = datePicker
    }
    
    @objc func doneInsulinPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        insulinField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func createPumpSetDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePumpPressed))
        toolbar.setItems([doneButton], animated: true)
        pumpField.startDateField.inputAccessoryView = toolbar
        pumpField.startDateField.inputView = datePicker
    }
    
    @objc func donePumpPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        pumpField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func createSensorDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSensorPressed))
        toolbar.setItems([doneButton], animated: true)
        sensorField.startDateField.inputAccessoryView = toolbar
        sensorField.startDateField.inputView = datePicker
    }
    
    @objc func doneSensorPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        sensorField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    let separatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let separatorView3: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let separatorView4: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let separatorView5: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private func addSubviews() {
        insulinProtocolStackView.addArrangedSubview(insulinImageView)
        insulinProtocolStackView.addArrangedSubview(insulinField)
        
        sensorProtocolStackView.addArrangedSubview(sensorImageView)
        sensorProtocolStackView.addArrangedSubview(sensorField)
        
        pumpProtocolStackView.addArrangedSubview(pumpImageView)
        pumpProtocolStackView.addArrangedSubview(pumpField)
        
        verticalStackView.addArrangedSubview(reminderLabel)
        verticalStackView.addArrangedSubview(separatorView1)
        verticalStackView.addArrangedSubview(insulinProtocolStackView)
        verticalStackView.addArrangedSubview(separatorView2)
        verticalStackView.addArrangedSubview(sensorProtocolStackView)
        verticalStackView.addArrangedSubview(separatorView3)
        verticalStackView.addArrangedSubview(pumpProtocolStackView)
        verticalStackView.addArrangedSubview(separatorView4)
    
        view.addSubview(verticalStackView)
    }

    private func addStackViewConstraints() {
        view.addConstraints([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            insulinImageView.widthAnchor.constraint(equalToConstant: 80),
            insulinField.heightAnchor.constraint(equalTo: insulinImageView.heightAnchor),
            
            sensorImageView.widthAnchor.constraint(equalToConstant: 80),
            sensorField.heightAnchor.constraint(equalTo: sensorImageView.heightAnchor),
            
            pumpImageView.widthAnchor.constraint(equalToConstant: 80),
            pumpField.heightAnchor.constraint(equalTo: pumpImageView.heightAnchor),


        ])
    }
    
}

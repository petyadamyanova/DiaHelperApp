//
//  ReminderViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 21.11.23.
//

import UIKit

class ReminderViewController: UIViewController {
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        createDatePicker()
        addSubviews()
        addStackViewConstraints()
    }
    
    internal var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sensorIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var sensorField: ReminderField = {
        let field = ReminderField()
        field.startLabel.text = "Start:"
        field.startLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        field.endLabel.text = "End:"
        field.endLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        field.startDateField.placeholder = "Enter start date"
        field.endDateField.text = "-"

        return field
    }()
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        sensorField.startDateField.inputAccessoryView = toolbar
        sensorField.startDateField.inputView = datePicker
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        sensorField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        if let endDate = Calendar.current.date(byAdding: .day, value: 10, to: datePicker.date) {
            sensorField.endDateField.text = dateFormatter.string(from: endDate)
        }
    }
    
    
    private func addSubviews() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(sensorField)
    }

    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalTo: sensorField.heightAnchor)


        ])
    }
}



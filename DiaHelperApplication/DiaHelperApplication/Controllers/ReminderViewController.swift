//
//  ReminderViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 21.11.23.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController {
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        createSensorDatePicker()
        createPumpDatePicker()
        createInsulinCanulaDatePicker()
        createGlucometerCanulaDatePicker()
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
    
    internal var sensorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    internal var pumpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    internal var insulinCanulaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    internal var glucometerCanulaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    public var reminderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Baskerville", size: 40)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reminders"
        label.textAlignment = .center
        label.textColor = UIColor(named: "newBlue")
        
        return label
    }()
    
    let sensorImageView: UIImageView = {
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
    
    let pumpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pumpIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var pumpField: ReminderField = {
        let field = ReminderField()
        field.startLabel.text = "Start:"
        field.startLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        field.endLabel.text = "End:"
        field.endLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        field.startDateField.placeholder = "Placing a set date "
        field.endDateField.text = "-"

        return field
    }()
    
    let insulinCanulaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "insulinPenIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var insulinCanulaField: InsulinCanulaReminderField = {
        let field = InsulinCanulaReminderField()
        field.nameLabel.text = "Insulin canula"
        field.startLabel.text = "Last change:"
        field.startLabel.widthAnchor.constraint(equalToConstant: 97).isActive = true
        field.startDateField.placeholder = "Enter date"

        return field
    }()
    
    let glucometerCanulaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "glucometerIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var glucometerCanulaField: InsulinCanulaReminderField = {
        let field = InsulinCanulaReminderField()
        field.nameLabel.text = "Glucometer canula"
        field.startLabel.text = "Last change:"
        field.startLabel.widthAnchor.constraint(equalToConstant: 97).isActive = true
        field.startDateField.placeholder = "Enter date"

        return field
    }()
    
    func createSensorDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSensorPressed))
        toolbar.setItems([doneButton], animated: true)
        sensorField.startDateField.inputAccessoryView = toolbar
        sensorField.startDateField.inputView = datePicker
    }
    
    func createPumpDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePumpPressed))
        toolbar.setItems([doneButton], animated: true)
        pumpField.startDateField.inputAccessoryView = toolbar
        pumpField.startDateField.inputView = datePicker
    }
    
    func createInsulinCanulaDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneInsulinCanulaPressed))
        toolbar.setItems([doneButton], animated: true)
        insulinCanulaField.startDateField.inputAccessoryView = toolbar
        insulinCanulaField.startDateField.inputView = datePicker
    }
    
    func createGlucometerCanulaDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneGlucometerCanulaPressed))
        toolbar.setItems([doneButton], animated: true)
        glucometerCanulaField.startDateField.inputAccessoryView = toolbar
        glucometerCanulaField.startDateField.inputView = datePicker
    }
    
    @objc func doneSensorPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        sensorField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        if let endDate = Calendar.current.date(byAdding: .day, value: 10, to: datePicker.date) {
            sensorField.endDateField.text = dateFormatter.string(from: endDate)
            scheduleNotification(datePicker.date, endDate)
        }
    }
    
    @objc func donePumpPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        pumpField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        if let endDate = Calendar.current.date(byAdding: .day, value: 3, to: datePicker.date) {
            pumpField.endDateField.text = dateFormatter.string(from: endDate)
        }
    }
    
    @objc func doneInsulinCanulaPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        insulinCanulaField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func doneGlucometerCanulaPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        glucometerCanulaField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
        sensorStackView.addArrangedSubview(sensorImageView)
        sensorStackView.addArrangedSubview(sensorField)
        
        pumpStackView.addArrangedSubview(pumpImageView)
        pumpStackView.addArrangedSubview(pumpField)
        
        insulinCanulaStackView.addArrangedSubview(insulinCanulaImageView)
        insulinCanulaStackView.addArrangedSubview(insulinCanulaField)
        
        glucometerCanulaStackView.addArrangedSubview(glucometerCanulaImageView)
        glucometerCanulaStackView.addArrangedSubview(glucometerCanulaField)
        
        verticalStackView.addArrangedSubview(reminderLabel)
        verticalStackView.addArrangedSubview(separatorView1)
        verticalStackView.addArrangedSubview(sensorStackView)
        verticalStackView.addArrangedSubview(separatorView2)
        verticalStackView.addArrangedSubview(pumpStackView)
        verticalStackView.addArrangedSubview(separatorView3)
        verticalStackView.addArrangedSubview(insulinCanulaStackView)
        verticalStackView.addArrangedSubview(separatorView4)
        verticalStackView.addArrangedSubview(glucometerCanulaStackView)
        verticalStackView.addArrangedSubview(separatorView5)
    
        view.addSubview(verticalStackView)
    }

    private func addStackViewConstraints() {
        view.addConstraints([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            sensorImageView.widthAnchor.constraint(equalToConstant: 80),
            sensorImageView.heightAnchor.constraint(equalTo: sensorField.heightAnchor),
            
            pumpImageView.widthAnchor.constraint(equalToConstant: 80),
            pumpImageView.heightAnchor.constraint(equalTo: pumpField.heightAnchor),
            
            insulinCanulaImageView.widthAnchor.constraint(equalToConstant: 80),
            insulinCanulaField.heightAnchor.constraint(equalTo: insulinCanulaImageView.heightAnchor),
            
            glucometerCanulaImageView.widthAnchor.constraint(equalToConstant: 80),
            glucometerCanulaField.heightAnchor.constraint(equalTo: glucometerCanulaImageView.heightAnchor)


        ])
    }
    
    func scheduleNotification(_ startDate: Date, _ endDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Your reminder is ending tomorrow!"

        // Calculate trigger date one day before the end date, at the same hour
        if let triggerDate = Calendar.current.date(byAdding: .day, value: -1, to: endDate) {
            let triggerDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled successfully!")
                }
            }
        }
    }

}



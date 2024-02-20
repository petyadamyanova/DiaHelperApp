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
        setupProtocolsButton()
        setupSubmitButton()
        addSubviews()
        addStackViewConstraints()
        fetchStartTime()
    }
    
    func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        return dateFormatter.date(from: dateString)
    }
    
    func fetchStartTime() {
        guard let userId = UUID(uuidString: UserManager.shared.getCurrentUserId()) else {
            print("Invalid user ID.")
            return
        }

        let fetchStartTimesAPI = FetchStartTimesAPI.shared

        fetchStartTimesAPI.fetchStartTimes(for: userId) { startTime in
            if let startTime = startTime?.first {
                DispatchQueue.main.async { [self] in
                    if let sensorStartDate = self.dateFromString(startTime.sensorStartDateTime) {
                        self.setStartAndEndDate(for: self.sensorField, with: sensorStartDate, endDateOffset: 10)
                    }

                    if let pumpStartDate = self.dateFromString(startTime.pumpStartDateTime) {
                        self.setStartAndEndDate(for: self.pumpField, with: pumpStartDate, endDateOffset: 3)
                    }

                    let insulinCanulaStartDate = startTime.insulinCanulaStartDateTime
                    setStartTimeForCanulaField(field: self.insulinCanulaField, startDateString: insulinCanulaStartDate)
                    
                    let glucometerCanulaStartDate = startTime.glucometerCanulaStartDateTime
                    setStartTimeForCanulaField(field: self.glucometerCanulaField, startDateString: glucometerCanulaStartDate)
                }


                print("Fetched start time: \(startTime)")
            } else {
                print("Error fetching start time.")
            }
        }
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
        setStartAndEndDate(for: sensorField, with: datePicker.date, endDateOffset: 10)
        self.view.endEditing(true)
    }
    
    @objc func donePumpPressed(){
        setStartAndEndDate(for: pumpField, with: datePicker.date, endDateOffset: 3)
        self.view.endEditing(true)
    }
    
    @objc func doneInsulinCanulaPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        insulinCanulaField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func doneGlucometerCanulaPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        glucometerCanulaField.startDateField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    public var protocolsButton: UIButton = {
        let color = UIColor(named: "newBlue")
        
        let button = UIButton(type: .system)
        button.setTitle("protocols", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private func setupProtocolsButton() {
        let action = UIAction(handler: protocolsButtonTapped)
        protocolsButton.addAction(action, for: .touchUpInside)
    }
    
    private func protocolsButtonTapped(_ action: UIAction) {
        let protocolsReminderViewController = ProtocolsReminderViewController()
        let navController = UINavigationController(rootViewController: protocolsReminderViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }
    
    public var submitButton: UIButton = {
        let color = UIColor(named: "newBlue")
        
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        button.configuration = buttonConfiguration
        return button
    }()
    
    private func setupSubmitButton() {
        let action = UIAction(handler: submitButtonTapped)
        submitButton.addAction(action, for: .touchUpInside)
    }
    
    private func submitButtonTapped(_ action: UIAction) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"

        if let sensorStartDateString = sensorField.startDateField.text,
               let sensorStartDate = dateFormatter.date(from: sensorStartDateString),
               let pumpStartDateString = pumpField.startDateField.text,
               let pumpStartDate = dateFormatter.date(from: pumpStartDateString),
               let insulinCanulaStartDateString = insulinCanulaField.startDateField.text,
               let insulinCanulaStartDate = dateFormatter.date(from: insulinCanulaStartDateString),
               let glucometerCanulaStartDateString = glucometerCanulaField.startDateField.text,
               let glucometerCanulaStartDate = dateFormatter.date(from: glucometerCanulaStartDateString) {

                let userId = UUID(uuidString: UserManager.shared.getCurrentUserId())!

                let startTimesData = StartTimes(
                    sensorStartDateTime: dateFormatter.string(from: sensorStartDate),
                    pumpStartDateTime: dateFormatter.string(from: pumpStartDate),
                    insulinCanulaStartDateTime: dateFormatter.string(from: insulinCanulaStartDate),
                    glucometerCanulaStartDateTime: dateFormatter.string(from: glucometerCanulaStartDate)
                )

                let addStartTimeAPI = AddStartTimeAPI()

                addStartTimeAPI.addStartTime(userId: userId.uuidString, startTime: startTimesData) { error in
                    if let error = error {
                        print("Error submitting start times: \(error)")
                    } else {
                        print("Start times submitted successfully!")
                    }
                }
        } else {
            print("Invalid date format for one of the fields")
        }
    }
    
    func setStartAndEndDate(for field: ReminderField, with startDate: Date, endDateOffset: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"

        field.startDateField.text = dateFormatter.string(from: startDate)
        
        if let endDate = Calendar.current.date(byAdding: .day, value: endDateOffset, to: startDate) {
            field.endDateField.text = dateFormatter.string(from: endDate)
            scheduleNotification(startDate, endDate)
        }
    }
    
    func setStartTimeForCanulaField(field: InsulinCanulaReminderField, startDateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"

        if let startDate = dateFormatter.date(from: startDateString) {
            field.startDateField.text = dateFormatter.string(from: startDate)
        } else {
            print("Invalid date format for canula field")
        }
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
        verticalStackView.addArrangedSubview(protocolsButton)
        verticalStackView.addArrangedSubview(submitButton)
    
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



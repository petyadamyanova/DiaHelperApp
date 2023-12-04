//
//  HomeViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class HomeViewController: UIViewController {
    var timer: Timer?
    
    let profileVC = ProfileViewController()
    
    private var nigtscout: String = ""
    
    public var bloodSugar: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public var addButton: UIButton = {
        let color = UIColor(named: "newBrown")
        
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private func setupReminderButton() {
        let color = UIColor(named: "newBrown")
        
        let reminderButton = UIButton(type: .system)
        reminderButton.setTitle("Reminder", for: .normal)
        reminderButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        reminderButton.setTitleColor(color, for: .normal)
        reminderButton.addTarget(self, action: #selector(didTapReminder), for: .touchUpInside)

       let reminderBarButton = UIBarButtonItem(customView: reminderButton)
       navigationItem.rightBarButtonItem = reminderBarButton
    }
    
    @objc private func didTapReminder(_ action: UIAction) {
        let reminderViewController = ReminderViewController()
        let navController = UINavigationController(rootViewController: reminderViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupAddButton()
        setupReminderButton()
        
        timer = Timer.scheduledTimer(timeInterval: 300.0, // 300 секунди = 5 минути
                                     target: self,
                                     selector: #selector(updateLabel),
                                     userInfo: nil,
                                     repeats: true)
        
        updateLabel()
        
        addSubviews()
        addViewConstraints()
        
    }
    
    private func setupAddButton() {
        let addAction = UIAction(handler: addButtonTapped)
        addButton.addAction(addAction, for: .touchUpInside)
    }
    
    
    private func addButtonTapped(_ action: UIAction) {
        let addNutritionViewController = AddNutritionViewController()
        let navController = UINavigationController(rootViewController: addNutritionViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(bloodSugar)
        view.addSubview(addButton)

    }
    
    func addViewConstraints() {
        NSLayoutConstraint.activate([
            bloodSugar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bloodSugar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bloodSugar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 64),
            addButton.heightAnchor.constraint(equalToConstant: 64),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func updateLabel() {
            NightscoutAPI.takeBloodSugar(withURL: "petiadam.nightscout.bg") { readings in
                if let readings = readings {
                    DispatchQueue.main.async {
                        if let firstReading = readings.first {
                            let roundedValue = (Double(firstReading.value) / 18.0).rounded(toPlaces: 2)
                            self.bloodSugar.text = String(roundedValue)
                            print("Your blood sugar is: \(roundedValue)")
                        } else {
                            print("No readings available.")
                        }
                    }
                } else {
                    print("Request failed or no items.")
                }
            }
        }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

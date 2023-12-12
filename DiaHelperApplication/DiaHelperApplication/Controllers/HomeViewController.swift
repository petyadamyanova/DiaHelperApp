//
//  HomeViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource  {
    var timer: Timer?
    var currentUser: User?
    var meals: [Meal] = []
    private let tableView = UITableView()
    
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
        
        let textAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: color as Any,
                .font: UIFont.systemFont(ofSize: 16)
            ]

        let reminderBarButton = UIBarButtonItem(title: "Reminder", style: .plain, target: self, action: #selector(didTapReminder))

        reminderBarButton.setTitleTextAttributes(textAttributes, for: .normal)

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
        
        if let user = UserManager.shared.getCurrentUser() {
            currentUser = user
            
            if let meals = currentUser?.meals, !meals.isEmpty {
                self.meals = meals
                tableView.reloadData()
            }
        }
        
        timer = Timer.scheduledTimer(timeInterval: 300.0, // 300 секунди = 5 минути
                                     target: self,
                                     selector: #selector(updateLabel),
                                     userInfo: nil,
                                     repeats: true)
        
        updateLabel()
        
        meals.append(Meal(timestamp: Date(), bloodSugar: 5.6, insulinDose: 6, carbsIntake: 5, foodType: .fast))
        
        meals.append(Meal(timestamp: Date(), bloodSugar: 5.7, insulinDose: 8, carbsIntake: 4, foodType: .slow))
        
        setupTableView()
        addSubviews()
        addViewConstraints()
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeVcMealTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        self.tableView.layer.borderColor = UIColor.systemGray6.cgColor
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.cornerRadius = 10;
    }
    
    
    private func setupAddButton() {
        let addAction = UIAction(handler: addButtonTapped)
        addButton.addAction(addAction, for: .touchUpInside)
    }
    
    
    private func addButtonTapped(_ action: UIAction) {
        let addNutritionViewController = AddNutritionViewController()
        addNutritionViewController.delegate = self
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: bloodSugar.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500)
            //CGFloat(16 + (44 * meals.count ))
        ])
    }
    
    @objc func updateLabel() {
        if let user = currentUser {
            NightscoutAPI.takeBloodSugar(withURL: user.nightscout) { readings in
                if let readings = readings {
                    DispatchQueue.main.async {
                        if let firstReading = readings.first {
                            let roundedValue = (Double(firstReading.value) / 18.0).rounded(toPlaces: 2)
                            self.bloodSugar.text = String(roundedValue)
                            UserManager.shared.setCurrentGlucose(String(roundedValue))
                            print("Your blood sugar is: \(roundedValue)")
                        } else {
                            print("No readings available.")
                        }
                    }
                } else {
                    print("Request failed or no items.")
                }
            }
        }else{
            print("There is no current user.")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeVcMealTableViewCell
        
        if indexPath.row == 0 {
            cell.bloodSugarLabel.text = "🩸"
            cell.carbsIntakeLabel.text = "🍽️"
            cell.foodTypeLabel.text = "type"
            cell.insulinDoseLabel.text = "💉"
            cell.timestampLabel.text = "   ⏰"
        } else {
            let meal = meals[indexPath.row - 1]
            cell.bloodSugarLabel.text = String(meal.bloodSugar)
            cell.carbsIntakeLabel.text = String(meal.carbsIntake)
            cell.insulinDoseLabel.text = String(meal.insulinDose)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            cell.timestampLabel.text = dateFormatter.string(from: meal.timestamp)
            
            cell.foodTypeLabel.text = meal.foodType.rawValue
        }
        
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension HomeViewController: AddNutritionViewControllerDelegate {
    func didAddMeal(_ meal: Meal) {
        meals.append(meal)
        self.tableView.reloadData()
    }
}

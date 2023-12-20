//
//  HomeViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, GlucometerValueViewControllerDelegate  {
    var timer: Timer?
    var currentUser: User?
    var meals: [Meal] = []
    private let tableView = UITableView()
    private var tableViewBottomConstraint: NSLayoutConstraint!
    
    public var bloodSugar: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public var mealsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Baskerville", size: 40)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Meals"
        label.textColor = UIColor(named: "newBlue")
        
        return label
    }()
    
    public var bloodSugarContainer: UIView = {
        let bloodSugarContainer = UIView()
        bloodSugarContainer.translatesAutoresizingMaskIntoConstraints = false
        bloodSugarContainer.layer.cornerRadius = 32
        bloodSugarContainer.backgroundColor = UIColor(named: "pastelBlue")
        bloodSugarContainer.clipsToBounds = true
        
        return bloodSugarContainer
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
    
    public var glucometerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "glucometerImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        self.navigationController?.isNavigationBarHidden = true
        
        if let user = UserManager.shared.getCurrentUser() {
            currentUser = user
            
            if let meals = currentUser?.meals, !meals.isEmpty {
                self.meals = meals
                tableView.reloadData()
            }
        }
        
        setupAddButton()
        glucometerAction()
        addTestMeals()
        setupTableView()
        addSubviews()
        addViewConstraints()
        setupTimer()
    }
    
    private func setupTimer() {
        if let user = currentUser {
            if user.nightscout.isEmpty{
                self.bloodSugar.text = "-"
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 300.0, // 300 секунди = 5 минути
                                     target: self,
                                     selector: #selector(updateLabel),
                                     userInfo: nil,
                                     repeats: true)
        
        updateLabel()
    }
    
    private func addTestMeals() {
        meals.append(Meal(timestamp: Date(), bloodSugar: 5.6, insulinDose: 6.7, carbsIntake: 50, foodType: .fast))
        
        meals.append(Meal(timestamp: Date(), bloodSugar: 5.7, insulinDose: 8, carbsIntake: 47.5, foodType: .slow))
        
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeVcMealTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.layer.borderColor = UIColor.systemGray6.cgColor
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.cornerRadius = 10;
        
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: CGFloat((44 * (meals.count + 1))))
        tableViewBottomConstraint.isActive = true
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
    
    private func glucometerAction() {
        glucometerButton.addTarget(self, action: #selector(self.glucometterButtonTapped), for: .touchUpInside)
    }
    
    @objc func glucometterButtonTapped(sender: UIButton){
        let glucometerValueViewController = GlucometerValueViewController()
        glucometerValueViewController.delegate = self
        let navController = UINavigationController(rootViewController: glucometerValueViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }
    
    private func addSubviews() {
        bloodSugarContainer.addSubview(bloodSugar)
        view.addSubview(bloodSugarContainer)
        view.addSubview(addButton)
        view.addSubview(mealsLabel)
        view.addSubview(glucometerButton)
        view.addSubview(tableView)
    }
    
    func addViewConstraints() {
        NSLayoutConstraint.activate([
            bloodSugarContainer.widthAnchor.constraint(equalToConstant: 64),
            bloodSugarContainer.heightAnchor.constraint(equalToConstant: 64),
            bloodSugarContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            bloodSugarContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            bloodSugar.centerXAnchor.constraint(equalTo: bloodSugarContainer.centerXAnchor),
            bloodSugar.centerYAnchor.constraint(equalTo: bloodSugarContainer.centerYAnchor),
            
            mealsLabel.leadingAnchor.constraint(equalTo: bloodSugarContainer.trailingAnchor, constant: 64),
            mealsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            mealsLabel.heightAnchor.constraint(equalToConstant: 64),
            
            glucometerButton.leadingAnchor.constraint(equalTo: mealsLabel.trailingAnchor, constant: 64),
            glucometerButton.centerYAnchor.constraint(equalTo: mealsLabel.centerYAnchor),
            glucometerButton.widthAnchor.constraint(equalToConstant: 64),
            glucometerButton.heightAnchor.constraint(equalToConstant: 64),

            
            addButton.widthAnchor.constraint(equalToConstant: 64),
            addButton.heightAnchor.constraint(equalToConstant: 64),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: bloodSugarContainer.bottomAnchor, constant: 16),
            tableViewBottomConstraint
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
                            self.bloodSugar.text = "-"
                        }
                    }
                } else {
                    print(UserManager.shared.getAllGlucometerBloodSugarTests())
                    print("Request failed or no items.")
                    return
                }
            }
        }else{
            print("There is no current user.")
        }
        
    }
    
    func updateLabelManually(_ value: Double){
        self.bloodSugar.text = String(value)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeVcMealTableViewCell
        
        if indexPath.row == 0 {
            cell.bloodSugarLabel.text = "🩸"
            cell.carbsIntakeLabel.text = " 🍽️"
            cell.foodTypeLabel.text = "type"
            cell.insulinDoseLabel.text = "💉"
            cell.timestampLabel.text = "   ⏰"
        } else {
            let meal = meals[indexPath.row - 1]
            cell.bloodSugarLabel.text = String(meal.bloodSugar)
            let epsilon = 0.0001
            
            if abs(meal.carbsIntake.truncatingRemainder(dividingBy: 1.0)) < epsilon {
                cell.carbsIntakeLabel.text = "\(Int(meal.carbsIntake)) g"
            } else {
                cell.carbsIntakeLabel.text = "\(meal.carbsIntake) g"
            }

            if abs(meal.insulinDose.truncatingRemainder(dividingBy: 1.0)) < epsilon {
                cell.insulinDoseLabel.text = "\(Int(meal.insulinDose)) u"
            } else {
                cell.insulinDoseLabel.text = "\(meal.insulinDose) u"
            }
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            cell.timestampLabel.text = dateFormatter.string(from: meal.timestamp)
            
            cell.foodTypeLabel.text = meal.foodType.rawValue
        }
        
        return cell
    }
    
    func didSubmitGlucometerTest(_ value: Double) {
        updateLabelManually(value)
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
        tableViewBottomConstraint.constant = CGFloat(44 * (meals.count + 1))
        self.tableView.reloadData()
    }
}

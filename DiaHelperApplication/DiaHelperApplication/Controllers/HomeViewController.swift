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
    
    internal var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center

        return stackView
    }()
    
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
        }
        
        let userID = UUID(uuidString: UserManager.shared.getCurrentUserId())!
        print(UserManager.shared.getCurrentUserId())
        
        FetchMealsAPI.shared.fetchMeals(for: userID) { [weak self] meals in
            guard let self = self, let meals = meals else { return }
            
            self.meals = meals
            tableView.reloadData()
        }
        
        setupTimer()
        setupAddButton()
        glucometerAction()
        setupTableView()
        addSubviews()
        addStackViewConstraints()
        addViewConstraints()
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
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(HomeVcMealTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        
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
        view.addSubview(stackView)

        stackView.addArrangedSubview(bloodSugarContainer)
        stackView.addArrangedSubview(mealsLabel)
        stackView.addArrangedSubview(glucometerButton)

        
        bloodSugarContainer.addSubview(bloodSugar)
        view.addSubview(addButton)
        view.addSubview(tableView)
        view.addSubview(stackView)
    }
    
    func addViewConstraints() {
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 64),
            addButton.heightAnchor.constraint(equalToConstant: 64),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: bloodSugarContainer.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16),
        ])
    }
    
    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            bloodSugarContainer.widthAnchor.constraint(equalToConstant: 64),
            bloodSugarContainer.heightAnchor.constraint(equalToConstant: 64),
            
            bloodSugar.centerXAnchor.constraint(equalTo: bloodSugarContainer.centerXAnchor),
            bloodSugar.centerYAnchor.constraint(equalTo: bloodSugarContainer.centerYAnchor),
            
            mealsLabel.leadingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: -35),
            mealsLabel.heightAnchor.constraint(equalToConstant: 64),
            
            glucometerButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -64),
            glucometerButton.centerYAnchor.constraint(equalTo: mealsLabel.centerYAnchor),
            glucometerButton.widthAnchor.constraint(equalToConstant: 64),
            glucometerButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    @objc func updateLabel() {
        if let user = currentUser {
            NightscoutAPI.takeBloodSugar(withID: user.nightscout) { readings in
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
                    //print(UserManager.shared.getAllGlucometerBloodSugarTests())
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
        
        cell.backgroundColor = .white
        
        if indexPath.row == 0 {
            cell.bloodSugarLabel.text = "🩸"
            cell.carbsIntakeLabel.text = " 🍽️"
            cell.foodTypeLabel.text = "type"
            cell.insulinDoseLabel.text = "💉"
            cell.timestampLabel.text = "   ⏰"
            cell.dateLabel.text = ""
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
            
            
            let timestampString = meal.timestamp
            
            let dateFormatterInput = DateFormatter()
            dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            if let date = dateFormatterInput.date(from: timestampString) {
                let dateFormatterOutput = DateFormatter()
                let dateFormatterOutput2 = DateFormatter()
                dateFormatterOutput.dateFormat = "HH:mm"
                dateFormatterOutput2.dateFormat = "MM-dd"
                cell.timestampLabel.text = dateFormatterOutput.string(from: date)
                cell.dateLabel.text = dateFormatterOutput2.string(from: date)
                cell.dateLabel.font = UIFont.italicSystemFont(ofSize: 14)
            } else {
                cell.timestampLabel.text = "Invalid Timestamp"
            }
            
            cell.foodTypeLabel.text = meal.foodType.rawValue
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if indexPath.row > 0 && indexPath.row <= meals.count {
                let deletedMeal = meals.remove(at: indexPath.row - 1)
                
                deleteMealFromAPI(mealId: deletedMeal.id)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }
    }

    func deleteMealFromAPI(mealId: String) {
        let userId = UserManager.shared.getCurrentUserId()

        let deleteMealAPI = DeleteMealAPI()
        deleteMealAPI.deleteMeal(userId: userId, mealId: mealId) { error in
            if let error = error {
                print("Error deleting meal from API: \(error)")
            } else {
                print("Meal deleted successfully from API")
            }
        }
    }
    
    func didSubmitGlucometerTest(_ value: Double) {
        updateLabelManually(value)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension HomeViewController: AddNutritionViewControllerDelegate {
    func didAddMeal(_ meal: Meal) {
        //print(UserManager.shared.getCurrentUserId())
        let userID = UUID(uuidString: UserManager.shared.getCurrentUserId())!
        
        FetchMealsAPI.shared.fetchMeals(for:userID) { [weak self] fetchedMeals in
            guard let self = self, let fetchedMeals = fetchedMeals else {
                return
            }

            self.meals.insert(meal, at: 0)
            self.meals = fetchedMeals
            self.tableView.reloadData()
        }
    }
}

//
//  AddNutritionViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 21.11.23.
//

import UIKit

protocol AddNutritionViewControllerDelegate: AnyObject {
    func didAddMeal(_ meal: Meal)
}

class AddNutritionViewController: UIViewController, UITextFieldDelegate {
    weak var delegate: AddNutritionViewControllerDelegate?
    private let tableView = UITableView()
    private let submitButton = UIButton()
    var selectedFoodType: FoodType?
    
    private lazy var foodTypePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private var Image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mealIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    public var errorField: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Error"
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView(style: .medium)
       indicator.hidesWhenStopped = true
       return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        setupImage()
        setupTableView()
        setupSubmitButton()
        setupErrorLabel()
        setupActivityIndicator()
        
        foodTypePickerView.delegate = self
        foodTypePickerView.dataSource = self
    }
    
    private func setupImage(){
        view.addSubview(Image)
        NSLayoutConstraint.activate([
            Image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            Image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            Image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Image.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        self.tableView.layer.borderColor = UIColor.systemGray6.cgColor
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.cornerRadius = 10;
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: Image.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: Image.bottomAnchor, constant: (44 * 5 ))
        ])
    }
    
    
    
    private func setupSubmitButton(){
        let color = UIColor(named: "newBrown")
        submitButton.setTitle("Submit", for: .normal)
        
        submitButton.setTitleColor(color, for: .normal)
        submitButton.tintColor = UIColor(named: "newBlue")
        
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.cornerStyle = .large
        submitButton.configuration = buttonConfiguration
        
        view.addSubview(submitButton)

        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16 + 16),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let submitAction = UIAction { [weak self] action in
            Task {
                await self?.didtapSubmitButton(action)
            }
        }
        submitButton.addAction(submitAction, for: .touchUpInside)
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: cancelAction)
    }
    
    private func didtapSubmitButton(_ action: UIAction) async {
        var timestamp: Date = Date()
        var bloodSugar: Double = 0.0
        var insulinDose: Double = 0.0
        var carbsIntake: Double = 0.0
        var foodType: FoodType = .other
        
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            switch indexPath.row {
            case 0:
               if let text = getCellTextFieldText(indexPath: indexPath), let carbsIntake1 = Double(text) {
                   carbsIntake = carbsIntake1
                   hideError()
               } else {
                   showError(message: "Carbs intake must be a valid number.")
                   return
               }
            case 1:
               if let text = getCellTextFieldText(indexPath: indexPath) {
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "HH:mm"
                   
                   if let enteredTime = dateFormatter.date(from: text) {
                       let calendar = Calendar.current
                       let currentDate = Date()
                       let timeComponents = calendar.dateComponents([.hour, .minute], from: enteredTime)
                       let updatedTimestamp = calendar.date(bySettingHour: timeComponents.hour!, minute: timeComponents.minute!, second: 0, of: currentDate)!
                       timestamp = updatedTimestamp
                       hideError()
                   } else {
                       showError(message: "Invalid time format. Please use HH:mm")
                       return
                   }
               }
            case 2:
               if let type = selectedFoodType {
                   foodType = type
               } else {
                   foodType = .other
               }
            case 3:
               if let text = getCellTextFieldText(indexPath: indexPath), let insulinDose1 = Double(text) {
                   insulinDose = insulinDose1
                   hideError()
               } else {
                   showError(message: "Invalid input for insulin dose.")
                   return
               }
            case 4:
                if let text = getCellTextFieldText(indexPath: indexPath), let glucose1 = Double(text) {
                    bloodSugar = glucose1
                    hideError()
                } else {
                    showError(message: "Invalid input for glucose.")
                    return
                }
            default:
                break
            }
        }
    
        let formatter = ISO8601DateFormatter()
        let timestampString = formatter.string(from: timestamp)
        
        print(timestampString)
        let userId = UUID(uuidString: UserManager.shared.getCurrentUserId())!
        
        do {
            let meal = Meal(id: userId.uuidString, timestamp: timestampString, bloodSugar: bloodSugar, insulinDose: insulinDose, carbsIntake: carbsIntake, foodType: foodType)
            let addMealAPI = AddMealAPI()
            
            activityIndicator.startAnimating()
            
            try await addMealAPI.addMeal(userId: userId.uuidString, meal: meal)
            
            activityIndicator.stopAnimating()
            
            UserManager.shared.addMeal(meal)
            
            delegate?.didAddMeal(meal)
            
            dismiss(animated: true)
        } catch {
            print("Error adding meal: \(error)")
            activityIndicator.stopAnimating()
            
        }
    }

    private func getCellTextFieldText(indexPath: IndexPath) -> String? {
        guard let cell = tableView.cellForRow(at: indexPath) as? NutritionTableViewCell else {
            return nil
        }
        return cell.rightTextField.text
    }

    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func setupErrorLabel() {
        view.addSubview(errorField)

        errorField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            errorField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            errorField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
        ])
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            activityIndicator.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 8),
        ])
    }

    private func showError(message: String) {
        errorField.text = message
        errorField.isHidden = false
    }

    private func hideError() {
        errorField.text = nil
        errorField.isHidden = true
    }


}

extension AddNutritionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NutritionTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.leftLabel.text = "Enter carbs 🍽️ (g)"
            cell.rightTextField.placeholder = "Enter Value"
            cell.rightTextField.textAlignment = .center
        case 1:
            cell.leftLabel.text = "Time"
            cell.rightTextField.placeholder = getCurrentTime()
            cell.rightTextField.delegate = self
        case 2:
            cell.leftLabel.text = "Food Type"
            cell.rightTextField.placeholder = "Food Type"
            cell.rightTextField.inputView = foodTypePickerView
            if let type = selectedFoodType {
                cell.rightTextField.text = type.rawValue
            }
            cell.rightTextField.textAlignment = .center
            cell.rightTextField.delegate = self
        case 3:
            cell.leftLabel.text = "Insulin dose 💉 (Units)"
            cell.rightTextField.placeholder = "Enter Value"
            cell.rightTextField.textAlignment = .center
        case 4:
            cell.leftLabel.text = "Glucose 🩸"
            cell.rightTextField.placeholder = getGlucose()
            cell.rightTextField.textAlignment = .center
            cell.rightTextField.delegate = self
        default:
            break
        }

        return cell
    }
    
    private func getGlucose() -> String {
        UserManager.shared.getCurrentGlucose()
    }
}

extension AddNutritionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let indexPath = indexPathForTextField(textField) {
            switch indexPath.row {
            case 1:
                let currentTime = getCurrentTime()
                textField.text = currentTime
                textField.textAlignment = .center
            case 4:
                let glucose = getGlucose()
                textField.text = glucose
                textField.textAlignment = .center
            default:
                break
            }
        }
    }

    private func indexPathForTextField(_ textField: UITextField) -> IndexPath? {
        let point = textField.convert(CGPoint.zero, to: tableView)
        return tableView.indexPathForRow(at: point)
    }
    
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
}

extension AddNutritionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FoodType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FoodType.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFoodType = FoodType.allCases[row]
        
        tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
    }
}

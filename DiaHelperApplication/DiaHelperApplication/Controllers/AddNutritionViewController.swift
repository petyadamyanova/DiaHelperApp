//
//  AddNutritionViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 21.11.23.
//

import UIKit

class AddNutritionViewController: UIViewController, UITextFieldDelegate {
    
    private let tableView = UITableView()
    private let submitButton = UIButton()
    private var foodTypePicker: UIPickerView?
    var selectedFoodType: FoodType?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        setupTableView()
        setupSubmitButton()
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16 + (44 * 4 ))
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
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
    }
    
    private func didtapSubmitButton(_ action: UIAction) {
    }
    
    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }

}

extension AddNutritionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NutritionTableViewCell
        
        switch indexPath.row {
            case 0:
                cell.leftLabel.text = "Enter carbs (g)"
                cell.rightTextField.placeholder = "Enter Value"
                cell.rightTextField.textAlignment = .center
            case 1:
                cell.leftLabel.text = "Time"
                cell.rightTextField.placeholder = getCurrentTime()
                cell.rightTextField.delegate = self
            case 2:
                cell.leftLabel.text = "Food Type"
                cell.rightTextField.placeholder = "Food Type"
                cell.rightTextField.inputView = getFoodTypePicker()
                cell.rightTextField.text = selectedFoodType?.rawValue ?? ""
                cell.rightTextField.textAlignment = .center
            case 3:
                cell.leftLabel.text = "Insulin dose (Units)"
                cell.rightTextField.placeholder = "Enter Value"
                cell.rightTextField.textAlignment = .center
            default:
                break
            }

        return cell
    }
    
    private func getFoodTypePicker() -> UIPickerView {
        if let picker = foodTypePicker {
            return picker
        }

        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        foodTypePicker = picker

        return picker
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
        if let indexPath = indexPathForPickerView(pickerView) {
            selectedFoodType = FoodType.allCases[row]
            print(FoodType.allCases[row])
            self.tableView.reloadRows(at: [indexPath], with: .none)
        } else{
            selectedFoodType = FoodType.allCases[row]
        }
    }

    private func indexPathForPickerView(_ pickerView: UIPickerView) -> IndexPath? {
        let point = pickerView.convert(CGPoint.zero, to: tableView)
        return tableView.indexPathForRow(at: point)
    }
}

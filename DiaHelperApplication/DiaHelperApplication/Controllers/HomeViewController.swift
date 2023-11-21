//
//  HomeViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class HomeViewController: UIViewController, ProfileViewControllerDelegate {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        profileVC.delegate = self

        
        timer = Timer.scheduledTimer(timeInterval: 300.0, // 300 секунди = 5 минути
                                     target: self,
                                     selector: #selector(updateLabel),
                                     userInfo: nil,
                                     repeats: true)
        
        updateLabel()
        
        setConstraints()
        
    }
    
    func setConstraints() {
        view.addSubview(bloodSugar)

        NSLayoutConstraint.activate([
            bloodSugar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bloodSugar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bloodSugar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    @objc func updateLabel() {
        takeBloodSugar(withURL: nigtscout) { result in
            if let result = result {
                DispatchQueue.main.async {
                    if let resultDouble = Double(result) {
                        let roundedValue = (resultDouble / 18.0).rounded(toPlaces: 2)
                        self.bloodSugar.text = String(roundedValue)
                        print("Your blood sugar is : \(roundedValue)")
                    } else {
                        print("Error with converting to Double.")
                    }
                }
            } else {
                print("Request failed or no items.")
            }
        }
    }
    
    func didSubmitNightscoutURL(_ nightscoutURL: String) {
        print("j")
        print(nightscoutURL)
        self.nigtscout = nightscoutURL
        updateLabel()
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

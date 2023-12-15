//
//  ViewController.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 4.11.23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        
        let vc1 = UINavigationController(rootViewController: ReminderViewController())
        let vc2 = UINavigationController(rootViewController: HomeViewController())
        let vc3 = UINavigationController(rootViewController: ProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "bell.circle")
        vc2.tabBarItem.image = UIImage(systemName: "house")
        vc3.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        vc1.title = "Reminders"
        vc2.title = "Home"
        vc3.title = "Profile"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3], animated: true)
        
        selectedIndex = 1
        
    }



}


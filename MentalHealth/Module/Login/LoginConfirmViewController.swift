//
//  LoginConfirmViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import UIKit

class LoginConfirmViewController: UIViewController {
    
    @IBAction func navigateToHomeScreen() {
        showAlert(title: "Success", description: "Login Successfull!")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find HomeViewController")
        }
    }

    override func viewDidLoad() {
        setCustomBackNavigationButton()
        super.viewDidLoad()
    }
}

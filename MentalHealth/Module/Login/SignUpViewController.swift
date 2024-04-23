//
//  SignUpViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/10/24.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var continueAsGuestButton: UIButton!
    @IBAction func tapAsGuest(_ sender: Any) {
        showAlert(title: "Success", description: "Continue as guest")
        LoginManager.shared.setLoggedIn(false)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find HomeViewController")
        }
    }
    
    @IBAction func navigateToLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "LogInViewController") as? LogInViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find LogInViewController")
        }
    }

    @IBAction func navigateToGenderScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginGenderViewController = storyboard.instantiateViewController(identifier: "LoginGenderViewController") as? LoginGenderViewController {
            navigationController?.pushViewController(loginGenderViewController, animated: true)
        } else {
            print("Can't find loginGenderViewController")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

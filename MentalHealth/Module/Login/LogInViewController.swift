//
//  LogInViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/15/24.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func tapAsGuest(_ sender: Any) {
        showAlert(title: "Success", description: "Continue as guest")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find HomeViewController")
        }
    }
    
    @IBAction func clickedSignInButton() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        FBNetworkLayer.shared.signIn(email: email, password: password) { result in
                switch result {
                case .success:
                    self.nagivateToHomeViewController()
                case .failure(let error):
                    self.showAlert(error: error)
                }
            }
    }
    
    private func nagivateToHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find HomeViewController")
        }
    }
    
    @IBAction func navigateToSignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find SignUpViewController")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tempIDPassword()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func tempIDPassword() {
        emailTextField.text = "testsurvey1@gmail.com"
        passwordTextField.text = "1211asdF!"
    }
}

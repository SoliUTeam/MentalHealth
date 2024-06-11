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
    @IBOutlet weak var rememberMeCheckMark: UIImageView!
    
    var rememberMeSelected: Bool = false
    
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
                if self.rememberMeSelected {
                    self.saveCredentials(email: email, password: password)
                } else {
                    self.clearCredentials()
                }
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
        loadCredentials()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleRememberMe))
        rememberMeCheckMark.addGestureRecognizer(tapGesture)
        rememberMeCheckMark.isUserInteractionEnabled = true
    }
    
    @objc private func toggleRememberMe() {
        rememberMeSelected.toggle()
        let imageName = rememberMeSelected ? "checkmark.square" : "square"
        rememberMeCheckMark.image = UIImage(systemName: imageName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    private func saveCredentials(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "savedEmail")
        UserDefaults.standard.set(password, forKey: "savedPassword")
    }
    
    private func loadCredentials() {
        let savedEmail = UserDefaults.standard.string(forKey: "savedEmail")
        let savedPassword = UserDefaults.standard.string(forKey: "savedPassword")
        
        if let email = savedEmail, let password = savedPassword {
            emailTextField.text = email
            passwordTextField.text = password
            rememberMeSelected = true
            rememberMeCheckMark.image = UIImage(systemName: "checkmark.square")
        }
    }
    
    private func clearCredentials() {
        UserDefaults.standard.removeObject(forKey: "savedEmail")
        UserDefaults.standard.removeObject(forKey: "savedPassword")
    }
}

//
//  SignUpViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/10/24.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.isSecureTextEntry = true
        }
    }
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
    
    @IBAction func checkEmailAndPassword() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            nextButton.isEnabled = false
            passwordTextField.textColor = .black
            return
        }
        nextButton.isEnabled = true
    }
    
    private func checkPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    private func setIDAndPassword() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            nextButton.isEnabled = false
            passwordTextField.textColor = .black
            return
        }
        LoginManager.shared.setEmail(email)
        LoginManager.shared.setPassword(password)
    }
    
    @IBAction func navigateToGenderScreen(_ sender: Any) {
        setIDAndPassword()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginGenderViewController = storyboard.instantiateViewController(identifier: "LoginGenderViewController") as? LoginGenderViewController {
            navigationController?.pushViewController(loginGenderViewController, animated: true)
        } else {
            print("Can't find loginGenderViewController")
        }
    }
    
    @objc func textFieldsDidChange(_ textField: UITextField) {
        checkEmailAndPassword()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        // Set the delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Add target for editingChanged event
        emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

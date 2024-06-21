//
//  LoginConfirmViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import UIKit

class LoginConfirmViewController: UIViewController {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.backgroundColor = .white
            self.containerView.addBorderAndColor(color: .soliuBlue, width: 1, corner_radius: 20)
        }
    }
    @IBOutlet weak var nickNameLabel: UILabel! {
        didSet {
            self.nickNameLabel.text = "Nickname: \(LoginManager.shared.getNickName())"
        }
    }
    @IBOutlet weak var genderLabel: UILabel! {
        didSet {
            self.genderLabel.text = "Gender: \(LoginManager.shared.getGender())"
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            self.ageLabel.text = "Age: \(LoginManager.shared.getAge())"
        }
    }
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            self.statusLabel.text = "Status: \(LoginManager.shared.getWorkStatus())"
        }
    }
    @IBOutlet weak var ethnicityLabel: UILabel! {
        didSet {
            self.ethnicityLabel.text = "Ethnicity: \(LoginManager.shared.getEthnicity())"
        }
    }

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .loginNextBackground
        button.addTarget(self, action: #selector(navigateToHomeScreen), for: .touchUpInside)
        return button
    }()
    
    /// Navigate to Hom View
    @objc
    func navigateToHomeScreen() {
        self.clickedConfirmation { [weak self] success in
            guard let self = self else { return }
            if !success {
                print("Login Failed")
            }
            else {
                showAlert(title: "Success", description: "Welcome \(LoginManager.shared.getNickName())!")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let homeTabBarController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
                    navigationController?.pushViewController(homeTabBarController, animated: true)
                } else {
                    print("Can't find homeTabBarController")
                }
            }}
    }
        
    override func viewDidLoad() {
        addSubView(button)
        setCustomBackNavigationButton()
        super.viewDidLoad()
        
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func clickedConfirmation(completion: @escaping (Bool) -> Void) {
        let userInfo = LoginManager.shared.getUserInfo()
        print("Sign Up Flow \(userInfo)")
        FBNetworkLayer.shared.createAccount(email: userInfo.email, password: userInfo.password) { error in
                if let error = error as? SignInError {
                    self.showAlert(error: error)
                    print("Failed to create account: \(error)")
                    completion(false)
                } else {
                    FBNetworkLayer.shared.fetchUserInformation(userInfo: userInfo) { error in
                        if let error = error as? SignInError {
                            self.showAlert(error: error)
                            print("Failed to create account: \(error)")
                            print("Failed to fetch user information: \(error)")
                            completion(false)
                        } else {
                            FBNetworkLayer.shared.addEmailToList(email: userInfo.email) { error in
                                if let error = error as? SignInError {
                                    self.showAlert(error: error)
                                    print("Failed to add email lists: \(error)")
                                    completion(false)
                                }
                                else {
                                    completion(true)
                                    LoginManager.shared.setMyUserInformation(userInfo)
                                    LoginManager.shared.setLoggedIn(true)
                                    print("User information successfully updated")
                                }
                            }
                           
                        }
                    }
                }
            }
    }
}

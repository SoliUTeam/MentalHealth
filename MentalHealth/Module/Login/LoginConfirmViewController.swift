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
            self.nickNameLabel.text = "Nickname: \(loginManager.getNickName())"
        }
    }
    @IBOutlet weak var genderLabel: UILabel! {
        didSet {
            self.genderLabel.text = "Gender: \(loginManager.getGender())"
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            self.ageLabel.text = "Age: \(loginManager.getAge())"
        }
    }
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            self.statusLabel.text = "Status: \(loginManager.getWorkStatus())"
        }
    }
    @IBOutlet weak var ethnicityLabel: UILabel! {
        didSet {
            self.ethnicityLabel.text = "Ethnicity: \(loginManager.getEthnicity())"
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
    
    @objc
    func navigateToHomeScreen() {
        self.clickedConfirmation()
        if loginManager.isLoggedIn() == false {
            print("Login Failed")
        }
        else {
            showAlert(title: "Success", description: "Welcome \(loginManager.getNickName())!")
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let homeTabBarController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
                navigationController?.pushViewController(homeTabBarController, animated: true)
            } else {
                print("Can't find homeTabBarController")
            }
        }
    }
    
    private var loginManager = LoginManager.shared
    
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
    
    // Format: ["Dennis", "male", "29", "employed", "Asian"]
    func createUserData() -> [String] {
        var userInfo: [String] = []
        userInfo.append(loginManager.getNickName())
        userInfo.append(loginManager.getGender())
        userInfo.append(loginManager.getAge())
        userInfo.append(loginManager.getWorkStatus())
        userInfo.append(loginManager.getEthnicity())
        return userInfo
    }
    
    func clickedConfirmation() {
        let userInfo = LoginManager.defualtTestUser
        FBNetworkLayer.shared.createAccount(email: userInfo.email, password: userInfo.password) { error in
                if let error = error {
                    print("Failed to create account: \(error)")
                } else {
                    FBNetworkLayer.shared.fetchUserInformation(userInfo: userInfo) { error in
                        if let error = error {
                            print("Failed to fetch user information: \(error)")
                        } else {
                            self.loginManager.setLoggedIn(true)
                            print("User information successfully updated")
                        }
                    }
                }
            }
        
    }
    

}

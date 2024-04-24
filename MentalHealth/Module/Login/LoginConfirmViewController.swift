//
//  LoginConfirmViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import UIKit

class LoginConfirmViewController: UIViewController {
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
        showAlert(title: "Success", description: "Login Successfull!")
        //send data to backend
//        LoginManager.shared.setEthnicity()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeTabBarController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
            navigationController?.pushViewController(homeTabBarController, animated: true)
        } else {
            print("Can't find homeTabBarController")
        }
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
}

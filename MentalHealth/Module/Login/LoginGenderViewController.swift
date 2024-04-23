//
//  LoginGenderViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import UIKit

class LoginGenderViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBAction func navigateToStatusScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginAgeViewController = storyboard.instantiateViewController(identifier: "LoginAgeViewController") as? LoginAgeViewController {
            navigationController?.pushViewController(loginAgeViewController, animated: true)
        } else {
            print("Can't find LoginStatusViewController")
        }
    }

    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 323, height: 40))
        button.layer.cornerRadius = button.layer.frame.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tabBarBorder.cgColor
        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        addSubView(button)
        setCustomBackNavigationButton()
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 15).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

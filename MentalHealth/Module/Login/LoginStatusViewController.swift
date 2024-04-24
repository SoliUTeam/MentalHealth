//
//  LoginStatusViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import Foundation
import UIKit

class LoginStatusViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.backgroundColor = .loginNextDisabled
        button.addTarget(self, action: #selector(navigateToEthnicityScreen), for: .touchUpInside)
        return button
    }()
    
    @objc
    func navigateToEthnicityScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginEthnicityViewController = storyboard.instantiateViewController(identifier: "LoginEthnicityViewController") as? LoginEthnicityViewController {
            navigationController?.pushViewController(loginEthnicityViewController, animated: true)
        } else {
            print("Can't find loginEthnicityViewController")
        }
    }
    
    let buttonOption: [WorkStatus] = [.student, .employed, .other]
    var selectedButtonIndex = 0
    
    override func viewDidLoad() {
        button.isEnabled = false
        addSubView(button)
        createSelectButton(label: buttonOption.map { $0.rawValue.capitalized }, spacing: 10, constraintWith: titleLabel) { selectedButton, buttonEnabled in
            self.selectedButtonIndex = selectedButton
            self.button.isEnabled = buttonEnabled
            LoginManager.shared.setWorkStatus(self.buttonOption[self.selectedButtonIndex])
        }
        
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
        if button.isEnabled {
            button.backgroundColor = .loginNextBackground
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

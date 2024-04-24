//
//  LoginNickNameViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/24/24.
//

import Foundation
import UIKit

class LoginNickNameViewController: UIViewController {
    lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your nickname"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var characterLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "\(maxCharacterLimit)"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .loginNextBackground
        button.addTarget(self, action: #selector(navigateToConfirmScreen), for: .touchUpInside)
        return button
    }()
    
    @objc
    func navigateToConfirmScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginConfirmViewController = storyboard.instantiateViewController(identifier: "LoginConfirmViewController") as? LoginConfirmViewController {
            navigationController?.pushViewController(loginConfirmViewController, animated: true)
        } else {
            print("Can't find LoginConfirmViewController")
        }
    }
    
    let maxCharacterLimit = 20 // Change this to your desired character limit
    
    override func viewDidLoad() {
        addSubView([nicknameTextField, characterLimitLabel,button])
        setCustomBackNavigationButton()
        super.viewDidLoad()
        NSLayoutConstraint.activate([
            nicknameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            characterLimitLabel.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            characterLimitLabel.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor, constant: -8)
        ])
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

extension LoginNickNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if newLength <= maxCharacterLimit {
            characterLimitLabel.text = "\(maxCharacterLimit - newLength)/\(maxCharacterLimit)"
            return true
        } else {
            return false
        }
    }
}

//
//  LoginNickNameViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/24/24.
//

import Foundation
import UIKit

class LoginNickNameViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your nickname"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()

    lazy var characterLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "0/\(maxCharacterLimit)"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.backgroundColor = .loginNextDisabled
        button.isEnabled = false
        button.addTarget(self, action: #selector(navigateToConfirmScreen), for: .touchUpInside)
        return button
    }()
    
    @objc
    func navigateToConfirmScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginConfirmViewController = storyboard.instantiateViewController(identifier: "LoginConfirmViewController") as? LoginConfirmViewController {
            LoginManager.shared.setNickName(nicknameTextField.text ?? "Guest")
            navigationController?.pushViewController(loginConfirmViewController, animated: true)
        } else {
            print("Can't find LoginConfirmViewController")
        }
    }
    
    let maxCharacterLimit = 20 // Change this to your desired character limit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameTextField.delegate = self
        addSubView([nicknameTextField, characterLimitLabel,button])
        setCustomBackNavigationButton()
        setView()
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.bounds.height / 2
        if button.isEnabled {
            button.backgroundColor = .loginNextBackground
            nicknameTextField.layer.borderColor = UIColor.soliuBlue.cgColor
        } else {
            button.backgroundColor = .loginNextDisabled
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setView() {
        NSLayoutConstraint.activate([
            nicknameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            characterLimitLabel.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            characterLimitLabel.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 45),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

extension LoginNickNameViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(){
        nicknameTextField.addBorderAndColor(color: .soliuBlue, width: 1, corner_radius: 8)
        guard let nicknameTextField = nicknameTextField.text else {return}
        characterLimitLabel.text = "\(String(describing: nicknameTextField.count))/\(maxCharacterLimit)"
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if newLength <= maxCharacterLimit {
            characterLimitLabel.font = .systemFont(ofSize: 12, weight: .regular)
            if newLength > 0 && newLength <= maxCharacterLimit {
                button.isEnabled = true
            } else {
                button.isEnabled = false
            }
            return true
        } else {
            return false
        }
    }
}

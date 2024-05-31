//
//  LoginAgeViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import UIKit

class LoginAgeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.backgroundColor = .loginNextDisabled
        button.addTarget(self, action: #selector(navigateToStatusScreen), for: .touchUpInside)
        return button
    }()
    
    lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your age"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.textAlignment = .center
        
        return textField
    }()
    
    @objc
    func navigateToStatusScreen() {
        setupAge()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginStatusViewController = storyboard.instantiateViewController(identifier: "LoginStatusViewController") as? LoginStatusViewController {
            navigationController?.pushViewController(loginStatusViewController, animated: true)
        } else {
            print("Can't find LoginStatusViewController")
        }
    }
    
    let maxCharacterLimit = 2 // Change this to your desired character limit
    
    override func viewDidLoad() {
        button.isEnabled = false
        addSubView([ageTextField,button])
        
        setCustomBackNavigationButton()
        setView()
        super.viewDidLoad()
        ageTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupAge() {
        guard let ageText = ageTextField.text else { return }
        guard let age = Int(ageText) else { return }
        LoginManager.shared.setAge(age)
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
    
    private func setView() {
        NSLayoutConstraint.activate([
            ageTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 120),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            ageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            button.heightAnchor.constraint(equalToConstant: 45),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}
extension LoginAgeViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(){
        ageTextField.addBorderAndColor(color: .soliuBlue, width: 1, corner_radius: 8)
        
        guard let age = ageTextField.text else {return}
        
        if age.isEmpty {
            button.isEnabled = false
        }
        else {
            button.isEnabled = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let maxLength = maxCharacterLimit // Set your maximum length here
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
    }
}



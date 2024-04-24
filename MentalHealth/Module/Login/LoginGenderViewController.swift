//
//  LoginGenderViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import UIKit

class LoginGenderViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func navigateToStatusScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginAgeViewController = storyboard.instantiateViewController(identifier: "LoginAgeViewController") as? LoginAgeViewController {
            navigationController?.pushViewController(loginAgeViewController, animated: true)
        } else {
            print("Can't find LoginStatusViewController")
        }
    }

    let buttonOption: [Gender] = [.male, .female, .other]
    var selectedButtonIndex = 0
    override func viewDidLoad() {
        selectedButtonIndex = createSelectButton(label: buttonOption.map { $0.rawValue.capitalized }, spacing: 10, constraintWith: titleLabel) { selectedButton in
            self.selectedButtonIndex = selectedButton
            LoginManager.shared.setGender(self.buttonOption[self.selectedButtonIndex])
        }
            //nextButton.isEnabled = true
        
        setCustomBackNavigationButton()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

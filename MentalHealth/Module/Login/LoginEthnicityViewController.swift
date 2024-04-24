//
//  LoginEthnicityViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import Foundation
import UIKit

class LoginEthnicityViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func navigateToEthnicityScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginConfirmViewController = storyboard.instantiateViewController(identifier: "LoginConfirmViewController") as? LoginConfirmViewController {
            navigationController?.pushViewController(loginConfirmViewController, animated: true)
        } else {
            print("Can't find LoginConfirmViewController")
        }
    }

    override func viewDidLoad() {
        createSelectButton(label: ["American Indian", "Alaska Native", "Asian", "Black", "African American", "Native Hawaiian", "Other Pacific Islander", "White", "Other"], spacing: 10, constraintWith: titleLabel)
        setCustomBackNavigationButton()
        super.viewDidLoad()
    }
}

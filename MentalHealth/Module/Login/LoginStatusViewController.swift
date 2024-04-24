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
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func navigateToEthnicityScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginEthnicityViewController = storyboard.instantiateViewController(identifier: "LoginEthnicityViewController") as? LoginEthnicityViewController {
            navigationController?.pushViewController(loginEthnicityViewController, animated: true)
        } else {
            print("Can't find LoginEthnicityViewController")
        }
    }

    override func viewDidLoad() {
        createSelectButton(label: ["Student", "Employed", "Other"], spacing: 10, constraintWith: titleLabel)
        setCustomBackNavigationButton()
        super.viewDidLoad()
    }
}

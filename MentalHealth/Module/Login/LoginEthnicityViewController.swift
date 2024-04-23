//
//  LoginEthnicityViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import Foundation
import UIKit

class LoginEthnicityViewController: UIViewController {
    
    @IBAction func navigateToEthnicityScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginConfirmViewController = storyboard.instantiateViewController(identifier: "LoginConfirmViewController") as? LoginConfirmViewController {
            navigationController?.pushViewController(loginConfirmViewController, animated: true)
        } else {
            print("Can't find LoginConfirmViewController")
        }
    }

    override func viewDidLoad() {
        setCustomBackNavigationButton()
        super.viewDidLoad()
    }
}

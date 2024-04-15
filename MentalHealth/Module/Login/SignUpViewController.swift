//
//  SignUpViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/10/24.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var continueAsGuestButton: UIButton!
    @IBAction func tapAsGuest(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find HomeViewController")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

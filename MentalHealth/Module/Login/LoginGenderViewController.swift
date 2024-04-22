//
//  LoginGenderViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/22/24.
//

import UIKit

class LoginGenderViewController: UIViewController {
    
    @IBAction func navigateToStatusScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginStatusViewController = storyboard.instantiateViewController(identifier: "LoginStatusViewController") as? LoginStatusViewController {
            navigationController?.pushViewController(loginStatusViewController, animated: true)
        } else {
            print("Can't find LoginStatusViewController")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

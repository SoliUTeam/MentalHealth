//
//  LogInViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/15/24.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    @IBAction func tapAsGuest(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "HomeTabBarController") as? HomeTabBarController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find HomeViewController")
        }
    }
    
    @IBAction func navigateToSignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeViewController = storyboard.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            print("Can't find SignUpViewController")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

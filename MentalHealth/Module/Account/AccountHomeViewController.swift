//
//  AccountHomeViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/5/24.
//

import Foundation
import UIKit

class AccountHomeViewController: UIViewController {
    private static let currentVersion = "1.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.homepageBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

//    @IBAction func soliuLink(_ sender: UIButton) {
//        if let url = URL(string: "https://soliu.org") {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
//    }
//    @IBAction func writeReview(_ sender: UIButton) {
//        if let url = URL(string: "https://www.apple.com/app-store/") {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
//    }

    func getCurrentAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "Unknown Version"
    }
}

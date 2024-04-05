//
//  AccountHomeViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/5/24.
//

import Foundation
import UIKit

class AccountHomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func soliuLink(_ sender: UIButton) {
        if let url = URL(string: "https://soliu.org") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func writeReview(_ sender: UIButton) {
        if let url = URL(string: "https://www.apple.com/app-store/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

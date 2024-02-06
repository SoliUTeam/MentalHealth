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

    @IBAction func youtubeLink(_ sender: UIButton) {
        if let url = URL(string: "https://soliu.org") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

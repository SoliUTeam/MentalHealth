//
//  MyDiaryViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/15/24.
//

import UIKit

class MyDiaryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

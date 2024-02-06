//
//  SurveyListDetailViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/4/24.
//

import Foundation
import UIKit
import Hero

class SurveyListDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHeroEnabled = true
        self.tableView.backgroundColor = .blue
    }
}

extension SurveyListDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

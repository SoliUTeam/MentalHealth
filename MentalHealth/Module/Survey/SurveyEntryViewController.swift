//
//  SurveyEntryViewController.swift
//  MentalHealth
//
//  Created by Yoon on 5/7/24.
//

import UIKit

class SurveyEntryViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomBackNavigationButton()
        startButton.layer.cornerRadius = startButton.bounds.height / 2
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func openSurveyListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let surveyListVC = storyboard.instantiateViewController(identifier: "SurveyListViewController") as? SurveyListViewController {
            navigationController?.pushViewController(surveyListVC, animated: true)
        } else {
            print("Can't find storyboard")
        }
    }
}

//
//  SurveyEntryViewController.swift
//  MentalHealth
//
//  Created by Yoon on 5/7/24.
//

import UIKit

class SurveyEntryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomBackNavigationButton()
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
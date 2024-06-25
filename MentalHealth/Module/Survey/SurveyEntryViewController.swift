//
//  SurveyEntryViewController.swift
//  MentalHealth
//
//  Created by Yoon on 5/7/24.
//

import UIKit

class SurveyEntryViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var seeMyScoreButton: UIButton!
    
    private var mostRecentTestScore: [Int: Int] = [:]
    
    private func setUpButtonUI() {
        if !hasTakenTestsBefore() {
            seeMyScoreButton.isHidden = true
        }
        
        startButton.layer.cornerRadius = 12
        seeMyScoreButton.layer.cornerRadius = 12
        startButton.backgroundColor = .soliuBlue
        seeMyScoreButton.backgroundColor = .soliuBlack
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomBackNavigationButton()
        setUpButtonUI()
    }
    
    private func hasTakenTestsBefore() -> Bool {
        if LoginManager.shared.getSurveyResult().isEmpty || !LoginManager.shared.isLoggedIn() {
            return false
        }
        self.setupMyRecentTestScore()
        return true
    }
    
    private func setupMyRecentTestScore() {
        let surveyResults = LoginManager.shared.getSurveyResult()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Set date format according to the example provided
        let sortedResults = surveyResults.sorted { first, second in
            guard let firstDate = dateFormatter.date(from: first.surveyDate),
                  let secondDate = dateFormatter.date(from: second.surveyDate) else {
                return false
            }
            return firstDate > secondDate
        }
        
        if let mostRecentResult = sortedResults.first {
            self.mostRecentTestScore = mostRecentResult.surveyAnswer.enumerated().reduce(into: [:]) { dict, pair in
                dict[pair.offset] = pair.element
            }
        }
        
        print(mostRecentTestScore)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func openSurveyResultViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let surveyResultVC = storyboard.instantiateViewController(identifier: "SurveyResultViewController") as? SurveyResultViewController {
            surveyResultVC.myTestScore = mostRecentTestScore
            navigationController?.pushViewController(surveyResultVC, animated: true)
            
        } else {
            print("Can't find storyboard")
        }
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

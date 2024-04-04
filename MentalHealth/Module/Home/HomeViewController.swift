//
//  ViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var wiseLabel: UILabel! {
        didSet {
            wiseLabel.animate(newTexts: changeWiseLabelString())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func changeWiseLabelString() -> [String] {
        var quoteArray = [String]()
        for text in InspiringQuote.allCases {
            quoteArray.append(text.rawValue)
        }
        return quoteArray
    }
    
    @IBAction func displaySurveyListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let surveyListVC = storyboard.instantiateViewController(identifier: "SurveyListViewController") as? SurveyListViewController {
                navigationController?.pushViewController(surveyListVC, animated: true)
            } else {
                print("Can't find storyboard")
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


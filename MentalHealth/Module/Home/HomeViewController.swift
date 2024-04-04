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
    @IBOutlet weak var myDiaryView: UIView!
    @IBOutlet weak var testView: UIView!
    override func viewDidLoad() {
        self.tabBarController?.tabBar.layer.borderWidth = 1
        self.tabBarController?.tabBar.layer.borderColor = UIColor.tabBarBorder.cgColor
        super.viewDidLoad()
        applyBoader(testView)
        applyBoader(myDiaryView)
        testView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(displaySurveyListViewController))
        tap.numberOfTapsRequired = 1
        testView.addGestureRecognizer(tap)
    }

    func changeWiseLabelString() -> [String] {
        var quoteArray = [String]()
        for text in InspiringQuote.allCases {
            quoteArray.append(text.rawValue)
        }
        return quoteArray
    }
    
    @objc
    func displaySurveyListViewController(_ sender: Any) {
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


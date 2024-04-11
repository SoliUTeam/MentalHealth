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
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    
    @IBOutlet weak var questionBannerView: UIView!
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var myDiaryView: UIView!
    @IBOutlet weak var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBoader(testView)
        applyBoader(myDiaryView)
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView, questionBannerView], with: UIColor.tabBarBorder)
        applyBoader(chartContainerView, backgroundColor: UIColor.chartBackground)
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


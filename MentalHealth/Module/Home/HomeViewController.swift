//
//  ViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import UIKit
import SwiftEntryKit

class HomeViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 12
            backgroundView.backgroundColor = UIColor.chartBackground
        }
    }
    @IBOutlet weak var wiseLabel: UILabel! {
        didSet {
            wiseLabel.animate(newTexts: changeWiseLabelString())
        }
    }
    @IBOutlet weak var calendarButton: UIButton!
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
    
    /// Swift Entry Kit Declaration
    var attributes = EKAttributes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.homepageBackground
        applyBoader([testView, myDiaryView, chartContainerView], with: .clear, backgroundColor: .white)
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView, questionBannerView], with: UIColor.clear, backgroundColor: UIColor.white)
        
        // Navigation
        tapAction(testView, selector: #selector(displaySurveyListViewController))
        tapAction(myDiaryView, selector: #selector(displayMyDiaryViewController))
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

    @objc
    func displayMyDiaryViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let surveyListVC = storyboard.instantiateViewController(identifier: "MyDiaryViewController") as? MyDiaryViewController {
            navigationController?.pushViewController(surveyListVC, animated: true)
        } else {
            print("Can't find MyDiaryViewController")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}


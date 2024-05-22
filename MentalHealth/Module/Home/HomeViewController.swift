//
//  ViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import UIKit
import SwiftEntryKit
import FSCalendar
import HealthKit

class HomeViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.backgroundColor = .clear
            applyGradientBackground(to: backgroundView, startColor: .homepageBackgroundStart, endColor: .homepageBackgroundEnd)
        }
    }
    @IBOutlet weak var wiseLabel: UILabel! {
        didSet {
            if let quote = getRandomQuote() {
                wiseLabel.animate(newTexts: "\"\(quote.first?.key ?? "")\"")
                quoteName.text =  quote.first?.value
            }
        }
    }
    @IBOutlet weak var quoteName: UILabel!
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    
    @IBOutlet weak var sundayDate: UILabel!
    @IBOutlet weak var mondayDate: UILabel!
    @IBOutlet weak var tuesdayDate: UILabel!
    @IBOutlet weak var wednesdayDate: UILabel!
    @IBOutlet weak var thursdayDate: UILabel!
    @IBOutlet weak var fridayDate: UILabel!
    @IBOutlet weak var saturdayDate: UILabel!
    
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    
    @IBOutlet weak var confirmationView: UILabel!
    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            self.questionLabel.text = getQuestionLabelText()
        }
    }
    @IBOutlet weak var yesButton: UIButton!
    @IBAction func clickYesButton() {
        DispatchQueue.main.async { [self] in
            self.questionConfirmView.isHidden = false
            self.confirmationView.text = "Dopamine detox successful!"
            applyBoader(questionConfirmView, with: .clear, backgroundColor: .surveyResultGreen)
        }
    }
    
    @IBOutlet weak var noButton: UIButton!
    @IBAction func clickNoButton() {
        DispatchQueue.main.async { [self] in
            self.questionConfirmView.isHidden = false
            self.confirmationView.text = "It’s okay. Let’s do better next time!"
            applyBoader(questionConfirmView, with: .clear, backgroundColor: .homepageNoBackground)
        }
    }
    
    @IBOutlet weak var questionBannerView: UIView!
    @IBOutlet weak var questionConfirmView: UIView!
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var myDiaryView: UIView!
    @IBOutlet weak var testView: UIView!

    private var dayArry: [UILabel: [UIView : UILabel]] = [:]
    private var healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //progressTrackBar for more clarity
        self.view.backgroundColor = UIColor.progressTrackBar
        
        //when user has been already done today, we need to validate this
        questionConfirmView.isHidden = true
        LoginManager.shared.getUserInformation()

        dayArry = [sundayDate: [sundayView: sundayLabel], mondayDate: [mondayView: mondayLabel], tuesdayDate: [tuesdayView: tuesdayLabel], wednesdayDate: [wednesdayView: wednesdayLabel], thursdayDate: [thursdayView: thursdayLabel], fridayDate: [fridayView: fridayLabel], saturdayDate: [saturdayView: saturdayLabel]]
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView], with: .homepageStroke, backgroundColor: .white)
        applyBoader([questionBannerView, testView, myDiaryView, chartContainerView], with: .homepageStroke, backgroundColor: .white)
        updateTodayView()

        // Navigation
        tapAction(testView, selector: #selector(displaySurveyListViewController))
        tapAction(myDiaryView, selector: #selector(displayMyDiaryViewController))
        
//        // Access Step Count
//        let healthKitTypes: Set = [ HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! ]
//        // Check for Authorization
//        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (bool, error) in
//            if (bool) {
//                // Authorization Successful
//                
//                self.getSteps { (result) in
//                    DispatchQueue.main.async {
//                        let stepCount = String(Int(result))
//                        self.stepsLabel.text = String(stepCount)
//                    }
//                }
//            } // end if
//        } // end of checking authorization
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func applyGradientBackground(to view: UIView, startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 25
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateTodayView() {
        let today = getCurrentDate()
        var index = -1
        for (day, view) in dayArry {
            for (dayView, dayLabel) in view {
                day.text = "\(Int(today)! + index)"
                if day.text == today {
                    applyBoader(dayView, with: .clear, backgroundColor: .chartMyScoreFill)
                    day.textColor = .white
                    dayLabel.textColor = .white
                    loadViewIfNeeded()
                }
            }
            index += 1
        }
    }
    
    func getQuestionLabelText() -> String {
        // can be fetch data from backend
        return "Was dopamine detox successful?"
    }
    
    @objc
    func displaySurveyListViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let surveyEntryVC = storyboard.instantiateViewController(identifier: "SurveyEntryViewController") as? SurveyEntryViewController {
            navigationController?.pushViewController(surveyEntryVC, animated: true)
        } else {
            print("Can't find storyboard")
        }
    }

    @objc
    func displayMyDiaryViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyDiaryFlow", bundle: Bundle.main)
        if let myDiaryVC = storyboard.instantiateViewController(identifier: "MyDiaryViewController") as? MyDiaryViewController {
            navigationController?.pushViewController(myDiaryVC, animated: true)
        } else {
            print("Can't find MyDiaryViewController")
        }
    }
}

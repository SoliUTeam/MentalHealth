//
//  ViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import UIKit
import SwiftEntryKit
import FSCalendar

class HomeViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 12
            backgroundView.backgroundColor = UIColor.chartMyScoreFill
        }
    }
    @IBOutlet weak var wiseLabel: UILabel! {
        didSet {
            if let quote = getRandomQuote() {
                wiseLabel.animate(newTexts: quote)
            }
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
    
    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            self.questionLabel.text = getQuestionLabelText()
        }
    }
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var questionBannerView: UIView!
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var myDiaryView: UIView!
    @IBOutlet weak var testView: UIView!
    
    @IBAction func didTapCalendarButton() {
        showCalendarPopUpView()
    }
    
    /// Swift Entry Kit Declaration
    var attributes = EKAttributes()
    
    private var dayArry: [UILabel: [UIView : UILabel]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.homepageBackground
        dayArry = [sundayDate: [sundayView: sundayLabel], mondayDate: [mondayView: mondayLabel], tuesdayDate: [tuesdayView: tuesdayLabel], wednesdayDate: [wednesdayView: wednesdayLabel], thursdayDate: [thursdayView: thursdayLabel], fridayDate: [fridayView: fridayLabel], saturdayDate: [saturdayView: saturdayLabel]]
        applyBoader([testView, myDiaryView, chartContainerView], with: .clear, backgroundColor: .white)
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView, questionBannerView], with: UIColor.clear, backgroundColor: UIColor.white)
        updateTodayView()

        // Navigation
        tapAction(testView, selector: #selector(displaySurveyListViewController))
        tapAction(myDiaryView, selector: #selector(displayMyDiaryViewController))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateTodayView() {
        let today = getCurrentDate()
        var index = -1
        for (day, view) in dayArry {
            for (dayView, dayLabel) in view {
                day.text = "\(Int(today)! + index)"
                if day.text == today {
                    applyBoader(dayView, with: .white)
                    day.textColor = .white
                    dayLabel.textColor = .white
                    loadViewIfNeeded()
                }
            }
            index += 1
        }
    }
    
    private func showCalendarPopUpView() {
        attributes = .bottomNote
//        attributes.displayMode = displayMode
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = 3
        attributes.screenBackground = .clear
        attributes.entryBackground = .clear
        attributes.screenInteraction = .forward
        attributes.entryInteraction = .absorbTouches
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.5,
                spring: .init(damping: 0.9, initialVelocity: 0)
            ),
            scale: .init(
                from: 0.8,
                to: 1,
                duration: 0.5,
                spring: .init(damping: 0.8, initialVelocity: 0)
            ),
            fade: .init(
                from: 0.7,
                to: 1,
                duration: 0.3
            )
        )
        attributes.exitAnimation = .init(
            translate: .init(
                duration: 0.5
            ),
            scale: .init(
                from: 1,
                to: 0.8,
                duration: 0.5
            ),
            fade: .init(
                from: 1,
                to: 0,
                duration: 0.5
            )
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(
                    duration: 0.3
                ),
                scale: .init(
                    from: 1,
                    to: 0.8,
                    duration: 0.3
                )
            )
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 6
            )
        )
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(
            width: .offset(value: 20),
            height: .intrinsic
        )
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: UIScreen.main.bounds.width),
            height: .intrinsic
        )
        attributes.statusBar = .ignored
        let myCustomView: CalendarPopUpView = CalendarPopUpView.fromNib()
        SwiftEntryKit.display(entry: CalendarPopUpViewController(with: myCustomView), using: attributes)
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


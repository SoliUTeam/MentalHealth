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
    
    @IBAction func didTapCalendarButton() {
        showCalendarPopUpView()
    }

    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        return calendar
    }()
    
    /// Swift Entry Kit Declaration
    var attributes = EKAttributes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.homepageBackground
        calendar.delegate = self
        calendar.dataSource = self
        applyBoader([testView, myDiaryView, chartContainerView], with: .clear, backgroundColor: .white)
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView, questionBannerView], with: UIColor.clear, backgroundColor: UIColor.white)
        
        // Navigation
        tapAction(testView, selector: #selector(displaySurveyListViewController))
        tapAction(myDiaryView, selector: #selector(displayMyDiaryViewController))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func showCalendarPopUpView() {
//        self.view.addSubview(calendar)
//        calendar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        calendar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
//        var attributes = EKAttributes.centerFloat
//        attributes.entryBackground = .color(color: .white)
////        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: .infinity), scale: .init(from: .infinity, to: .infinity, duration: .infinity)))
//        attributes.displayDuration = .infinity
//        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
//        attributes.statusBar = .dark
//        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
//
//        var attributes = EKAttributes.pop
//
//        // Set its background to white
//        attributes.entryBackground = .color(color: .black)
//
//        // Animate in and out using default translation
//        attributes.entranceAnimation = .translation
//        attributes.exitAnimation = .translation

        let customView = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 320))
        /*
        ... Customize the view as you like ...
        */

        // Display the view with the configuration
        SwiftEntryKit.display(entry: customView, using: attributes)
        /*
        ... Customize the view as you like ...
        */
        //let contentView = UIView
        // Display the view with the configuration
//        let conte = CalendarPopUpView()
        
//        customView.backgroundColor = .black
//        SwiftEntryKit.display(entry: customView, using: attributes)
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
}
extension HomeViewController: FSCalendarDelegate {
    
}
extension HomeViewController: FSCalendarDataSource {
    
}

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
    
    @IBAction func didTapCalendarButton() {
        showCalendarPopUpView()
    }

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func showAlert(message: String) {
        var attributes = EKAttributes.centerFloat
        attributes.entryBackground = .color(color: .white)
//        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: .infinity), scale: .init(from: .infinity, to: .infinity, duration: .infinity)))
        attributes.displayDuration = .infinity
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
    }
    
    private func showCalendarPopUpView() {
        var attributes = EKAttributes.centerFloat
        attributes.entryBackground = .color(color: .white)
//        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: .infinity), scale: .init(from: .infinity, to: .infinity, duration: .infinity)))
        attributes.displayDuration = .infinity
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
        // Set its background to white

        // Animate in and out using default translation
//        attributes.entranceAnimation = .translation
//        attributes.exitAnimation = .translation
        //let contentView = UIView()
        let title = EKProperty.LabelContent(text: "titleText", style: .init(font: .boldSystemFont(ofSize: 16), color: .black))
        let description = EKProperty.LabelContent(text: "descText", style: .init(font: .boldSystemFont(ofSize: 16), color: .black))
        let image = EKProperty.ImageContent(image: UIImage(emotionAssetIdentifier: .star)!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        /*
        ... Customize the view as you like ...
        */

        // Display the view with the configuration
        SwiftEntryKit.display(entry: contentView, using: attributes)
//        let customView = UIView(frame: CGRect(x: 100, y: 300, width: 300, height: 300))
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


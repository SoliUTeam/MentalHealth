//
//  DayViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/4/24.
//

import UIKit
import Foundation

class DayViewController: UIViewController {
    @IBOutlet weak var currentDate: UILabel! {
        didSet {
            self.currentDate.text = getCurrentMonthAndDate()
        }
    }
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    
    // Need to discuss how to display date
    @IBOutlet weak var sundayDate: UILabel!
    @IBOutlet weak var mondayDate: UILabel!
    @IBOutlet weak var tuesdayDate: UILabel!
    @IBOutlet weak var wednesdayDate: UILabel!
    @IBOutlet weak var thursdayDate: UILabel!
    @IBOutlet weak var fridayDate: UILabel!
    @IBOutlet weak var saturdayDate: UILabel!
    
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            self.nameLabel.text = "Hi Nickname!"
        }
    }
    
    @IBOutlet weak var feelingOptionView: UIView!
    
    lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.7
        progressView.progressTintColor = UIColor.progressBar
        progressView.trackTintColor = UIColor.progressTrackBar
        progressView.layer.cornerRadius = progressView.frame.width / 2
        progressView.clipsToBounds = true
        progressView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

    lazy var starIcon: UIImageView = {
        let starIcon = UIImageView()
        starIcon.image = UIImage.getImage(.star)
        starIcon.frame.size = CGSize(width: 11, height: 11)
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        return starIcon
    }()

    lazy var starCountLabel: UILabel = {
        let label = UILabel()
        label.text = getStarCount()
        label.textColor = UIColor.soliuBlack
        label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(progressBar)
        progressBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: 12).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: welcomeView.frame.height).isActive = true
        makeCircleShape(welcomeView)
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView], with: UIColor.tabBarBorder)
        applyStyle(feelingOptionView)
    }
    
    override func viewDidLayoutSubviews() {
        let width = progressBar.bounds.width
        let height = progressBar.bounds.height

        progressBar.bounds.size.width = height
        progressBar.bounds.size.height = width
    }
    
    func getStarCount() -> String {
        // need to call it from backend
        return "10"
    }
    
    func applyStyle(_ view: UIView) {
        view.layer.cornerRadius = view.layer.frame.height / 2
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

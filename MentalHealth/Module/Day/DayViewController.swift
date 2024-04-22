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
            if LoginManager.shared.isLoggedIn() {
                self.nameLabel.text = LoginManager.shared.getNickName()
            } else {
                self.nameLabel.text = "Hi Guest!"
            }
        }
    }
    @IBOutlet weak var bigIconImageView: UIImageView!
    
    @IBOutlet weak var feelingOptionView: UIView!

    @IBOutlet weak var badButton: UIButton! {
        didSet {
            if !badButton.isSelected {
                self.badButton.setImage(UIImage(emotionAssetIdentifier: .badIcon), for: .normal)
            }
        }
    }
    @IBOutlet weak var sadButton: UIButton! {
        didSet {
            if !sadButton.isSelected {
                self.sadButton.setImage(UIImage(emotionAssetIdentifier: .sadIcon), for: .normal)
            }
        }
    }
    @IBOutlet weak var decentButton: UIButton! {
        didSet {
            if !decentButton.isSelected {
                self.decentButton.setImage(UIImage(emotionAssetIdentifier: .decentIcon), for: .normal)
            }
        }
    }
    @IBOutlet weak var goodButton: UIButton! {
        didSet {
            if !goodButton.isSelected {
                self.goodButton.setImage(UIImage(emotionAssetIdentifier: .goodIcon), for: .normal)
            }
        }
    }
    @IBOutlet weak var niceButton: UIButton! {
        didSet {
            if !niceButton.isSelected {
                self.niceButton.setImage(UIImage(emotionAssetIdentifier: .niceIcon), for: .normal)
            }
        }
    }
    
    lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView()
        // Default max star value is 100
        progressView.progress = getStarCount().floatValue / 100
        progressView.progressTintColor = UIColor.progressBar
        progressView.trackTintColor = UIColor.progressTrackBar
        progressView.layer.cornerRadius = 6
        progressView.layer.borderColor = UIColor.progressBarBorder.cgColor
        progressView.layer.borderWidth = 0.5
        progressView.clipsToBounds = true
        progressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

    lazy var starIcon: UIImageView = {
        let starIcon = UIImageView()
        starIcon.image = UIImage(emotionAssetIdentifier: .star)
        starIcon.frame.size = CGSize(width: 11, height: 11)
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        return starIcon
    }()

    lazy var starCountLabel: UILabel = {
        let label = UILabel()
        label.text = getStarCount()
        label.textColor = UIColor.soliuBlack
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        
        switch sender {
        case badButton:
            
            badButton.setImage(UIImage(emotionAssetIdentifier: .badIconSelected), for: .selected)
            bigIconImageView.image = UIImage(emotionAssetIdentifier: .badIconBig)
            bigIconImageView.contentMode = .scaleAspectFill
            badButton.backgroundColor = .clear
            changeButtonState(button: badButton)
        case sadButton:
            
            sadButton.setImage(UIImage(emotionAssetIdentifier: .sadIconSelected), for: .selected)
            bigIconImageView.image = UIImage(emotionAssetIdentifier: .sadIconBig)
            changeButtonState(button: sadButton)
        case decentButton:
      
            decentButton.setImage(UIImage(emotionAssetIdentifier: .decentIconSelected), for: .selected)
            bigIconImageView.image = UIImage(emotionAssetIdentifier: .decentIconBig)
            changeButtonState(button: decentButton)
        case goodButton:
            
            goodButton.setImage(UIImage(emotionAssetIdentifier: .goodIconSelected), for: .selected)
            bigIconImageView.image = UIImage(emotionAssetIdentifier: .goodIconBig)
            changeButtonState(button: goodButton)
        case niceButton:
        
            niceButton.setImage(UIImage(emotionAssetIdentifier: .niceIconSelected), for: .selected)
            bigIconImageView.image = UIImage(emotionAssetIdentifier: .niceIconBig)
            changeButtonState(button: niceButton)
        default:
            return
        }
    }
    
    private var loginManager = LoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(progressBar)
        self.view.addSubview(starIcon)
        self.view.addSubview(starCountLabel)
        
        progressBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: welcomeView.centerYAnchor).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: 12).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: welcomeView.frame.height).isActive = true
        
        starIcon.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 5).isActive = true
        starIcon.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor).isActive = true

        starCountLabel.topAnchor.constraint(equalTo: starIcon.bottomAnchor, constant: 3).isActive = true
        starCountLabel.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor).isActive = true
        starCountLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        starCountLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        makeCircleShape(welcomeView)
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView], with: UIColor.tabBarBorder)
        applyStyle(feelingOptionView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        let width = progressBar.bounds.width
        let height = progressBar.bounds.height

        progressBar.bounds.size.width = height
        progressBar.bounds.size.height = width
    }
    
    func getStarCount() -> String {
        if loginManager.isLoggedIn() {
            return "0"
        } else {
            return "10"
        }
    }
    
    func changeButtonState(button: UIButton) {
        badButton.isSelected = false
        sadButton.isSelected = false
        decentButton.isSelected = false
        goodButton.isSelected = false
        niceButton.isSelected = false
        button.isSelected = true
    }
    
    func applyStyle(_ view: UIView) {
        view.layer.cornerRadius = view.layer.frame.height / 2
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

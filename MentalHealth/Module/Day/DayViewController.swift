//
//  DayViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/4/24.
//

import UIKit
import Foundation
import Combine

class DayViewController: UIViewController {
    var imageUpdatePublisher = PassthroughSubject<UIImage, Never>()
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
    
    @IBOutlet weak var sundayStar: UIImageView!
    @IBOutlet weak var mondayStar: UIImageView!
    @IBOutlet weak var tuesdayStar: UIImageView!
    @IBOutlet weak var wednesdayStar: UIImageView!
    @IBOutlet weak var thursdayStar: UIImageView!
    @IBOutlet weak var fridayStar: UIImageView!
    @IBOutlet weak var saturdayStar: UIImageView!
    
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
    
    @IBOutlet weak var sundayEmoji: UIImageView!
    @IBOutlet weak var mondayEmoji: UIImageView!
    @IBOutlet weak var tuesdayEmoji: UIImageView!
    @IBOutlet weak var wednesdayEmoji: UIImageView!
    @IBOutlet weak var thursdayEmoji: UIImageView!
    @IBOutlet weak var fridayEmoji: UIImageView!
    @IBOutlet weak var saturdayEmoji: UIImageView!
    
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
        return progressView
    }()

    lazy var starIcon: UIImageView = {
        let starIcon = UIImageView()
        starIcon.image = UIImage(emotionAssetIdentifier: .star)
        starIcon.frame.size = CGSize(width: 11, height: 11)
        return starIcon
    }()

    lazy var starCountLabel: UILabel = {
        let label = UILabel()
        label.text = getStarCount()
        label.textColor = UIColor.soliuBlack
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .center
        return label
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 78, height: 24))
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = button.layer.frame.height / 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = UIColor.submitButtonBackground
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        
        if !isUserFinishedAction() {
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
    }
    
    private var dayArry: [UILabel: [UIView : UILabel]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.homepageBackground

        addSubView([progressBar, starIcon, starCountLabel, submitButton])
        
        //Set View Constraint
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

        submitButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: feelingOptionView.trailingAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: feelingOptionView.bottomAnchor, constant: 5).isActive = true
        submitButton.isHidden = true
        
        dayArry = [sundayDate: [sundayView: sundayLabel], mondayDate: [mondayView: mondayLabel], tuesdayDate: [tuesdayView: tuesdayLabel], wednesdayDate: [wednesdayView: wednesdayLabel], thursdayDate: [thursdayView: thursdayLabel], fridayDate: [fridayView: fridayLabel], saturdayDate: [saturdayView: saturdayLabel]]
        //set alpha to 0 hide all at very first time or  we can fetch data brom backend
        hideWithAlpha([sundayStar, mondayStar, tuesdayStar, wednesdayStar, thursdayStar, fridayStar, saturdayStar])
        makeCircleShape(welcomeView)
        
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView], with: .homepageStroke, backgroundColor: .white)
        applyStyle(feelingOptionView)
        
        dateSettingForWeekday([sundayDate, mondayDate, tuesdayDate, wednesdayDate, thursdayDate, fridayDate, saturdayDate])
        updateTodayView()
        setUpMyRecentMood()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setUpMyRecentMood() {
        let moodList = WeekViewHelper.createfilteredMood()
        let dateFormatter = WeekViewHelper.getMoodDateFormat()
        
        for targetMood in moodList {
            if let moodDate = dateFormatter.date(from: targetMood.date) {
                        let weekday = Calendar.current.component(.weekday, from: moodDate)
                updateRecentMood(for: weekday, mood: targetMood.myMood)
            }
        }
    }
    
    private func updateRecentMood(for weekday: Int, mood: MyMood) {
        
        switch weekday {
        case 1:
            sundayStar.alpha = 1
            sundayEmoji.image = mood.moodImage
        case 2:
            mondayStar.alpha = 1
            mondayEmoji.image = mood.moodImage
        case 3:
            tuesdayStar.alpha = 1
            tuesdayEmoji.image = mood.moodImage
        case 4:
            wednesdayStar.alpha = 1
            wednesdayEmoji.image = mood.moodImage
        case 5:
            thursdayStar.alpha = 1
            thursdayEmoji.image = mood.moodImage
        case 6:
            fridayStar.alpha = 1
            fridayEmoji.image = mood.moodImage
        case 7:
            saturdayStar.alpha = 1
            saturdayEmoji.image = mood.moodImage
        default :
            hideWithAlpha([sundayStar, mondayStar, tuesdayStar, wednesdayStar, thursdayStar, fridayStar, saturdayStar])
        }
    }
    
    override func viewDidLayoutSubviews() {
        let width = progressBar.bounds.width
        let height = progressBar.bounds.height

        progressBar.bounds.size.width = height
        progressBar.bounds.size.height = width
    }
    
    func getStarCount() -> String {
        if LoginManager.shared.isLoggedIn() {
            return "10"
        } else {
            return "0"
        }
    }
    
    func changeButtonState(button: UIButton) {
        badButton.isSelected = false
        sadButton.isSelected = false
        decentButton.isSelected = false
        goodButton.isSelected = false
        niceButton.isSelected = false
        button.isSelected = true
        welcomeView.isHidden = true
        submitButton.isHidden = false
    }
    
    private func submitMoodInformation(myMood: MyMood) {
        let myDay = MyDay(date: Date().toString(), myMood: myMood)
        print("SelectedMood \(myMood)")
        FBNetworkLayer.shared.fetchMyDay(userInfomration: LoginManager.shared.getUserInfo(),
                                         myDay: myDay) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    

    @objc
    func submitButtonTapped() {
        //send backend that user finished for today
        var selectedButton: UIButton?
        var mood: MyMood?
        for button in [badButton, sadButton, decentButton, goodButton, niceButton] {
            if button?.isSelected == true {
                selectedButton = button
                switch button {
                case badButton:
                    mood = .bad
                case sadButton:
                    mood = .sad
                case decentButton:
                    mood = .decent
                case goodButton:
                    mood = .good
                case niceButton:
                    mood = .nice
                default:
                    break
                }
                break
            }
        }
    
        if let selectedMood = mood {
               submitMoodInformation(myMood: selectedMood)
           } else {
               print("No mood selected")
               // Handle the case where no button was selected (e.g., show an alert to the user)
        }
        guard let selectedButton = selectedButton else {
                print("No button selected")
                return
        }
        let weekday = getTodayWeekday()
        switch weekday {
        case "Sunday":
            sundayStar.alpha = 1
            sundayEmoji.image = iconEmojiMap(button: selectedButton)
            imageUpdatePublisher.send(sundayEmoji.image.orEmptyImage)
        case "Monday":
            mondayStar.alpha = 1
            mondayEmoji.image = iconEmojiMap(button: selectedButton)
            imageUpdatePublisher.send(mondayEmoji.image.orEmptyImage)
        case "Tuesday":
            tuesdayStar.alpha = 1
            tuesdayEmoji.image = iconEmojiMap(button: selectedButton)
            imageUpdatePublisher.send(tuesdayEmoji.image.orEmptyImage)
        case "Wednesday":
            wednesdayStar.alpha = 1
            wednesdayEmoji.image = iconEmojiMap(button: selectedButton)
            imageUpdatePublisher.send(wednesdayEmoji.image.orEmptyImage)
        case "Thursday":
            thursdayStar.alpha = 1
            thursdayEmoji.image = iconEmojiMap(button: selectedButton)
            imageUpdatePublisher.send(thursdayEmoji.image.orEmptyImage)
        case "Friday":
            fridayStar.alpha = 1
            fridayEmoji.image = iconEmojiMap(button: selectedButton)
            imageUpdatePublisher.send(fridayEmoji.image.orEmptyImage)
        case "Saturday":
            saturdayStar.alpha = 1
            saturdayEmoji.image = iconEmojiMap(button: selectedButton)
            imageUpdatePublisher.send(saturdayEmoji.image.orEmptyImage)
        default :
            hideWithAlpha([sundayStar, mondayStar, tuesdayStar, wednesdayStar, thursdayStar, fridayStar, saturdayStar])
            
        }
    }
        
    func iconEmojiMap(button: UIButton?) -> UIImage? {
        guard let currentImage = button?.currentImage else { return nil }
        
        switch currentImage {
        case UIImage(emotionAssetIdentifier: .badIconSelected):
            return UIImage(emotionAssetIdentifier: .badIconBig)
        case UIImage(emotionAssetIdentifier: .sadIconSelected):
            return UIImage(emotionAssetIdentifier: .sadIconBig)
        case UIImage(emotionAssetIdentifier: .decentIconSelected):
            return UIImage(emotionAssetIdentifier: .decentIconBig)
        case UIImage(emotionAssetIdentifier: .goodIconSelected):
            return UIImage(emotionAssetIdentifier: .goodIconBig)
        case UIImage(emotionAssetIdentifier: .niceIconSelected):
            return UIImage(emotionAssetIdentifier: .niceIconBig)
        default:
            return nil
        }
    }
    

    func isUserFinishedAction()  -> Bool {
        // need a function that if user already did for today or not
        // true -> if user already finished for today
        // false -> user didnt finish for today
        return false
    }

    func updateTodayView() {
        for (dateLabel, viewDict) in dayArry {
            for (dayView, dayLabel) in viewDict {
                if dateLabel.text == getCurrentDate() {
                    applyBoader(dayView, with: .clear, backgroundColor: .chartMyScoreFill)
                    dateLabel.textColor = .progressTrackBar
                    dayLabel.textColor = .progressTrackBar
                }
            }
        }
    }

    func applyStyle(_ view: UIView) {
        view.layer.cornerRadius = view.layer.frame.height / 2
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

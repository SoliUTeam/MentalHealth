//
//  ViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import Combine
import DGCharts
import UIKit
import SwiftEntryKit
import FSCalendar
import HealthKit

class HomeViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
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
    
    @IBOutlet weak var sundayEmoji: UIImageView!
    @IBOutlet weak var mondayEmoji: UIImageView!
    @IBOutlet weak var tuesdayEmoji: UIImageView!
    @IBOutlet weak var wednesdayEmoji: UIImageView!
    @IBOutlet weak var thursdayEmoji: UIImageView!
    @IBOutlet weak var fridayEmoji: UIImageView!
    @IBOutlet weak var saturdayEmoji: UIImageView!
    
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
    @IBOutlet weak var setCountLabel: UILabel!
    @IBOutlet weak var myDiaryView: UIView!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var barChartView: BarChartView!
    
    private var dayArry: [UILabel: [UIView : UILabel]] = [:]
    private var healthStore = HKHealthStore()
    var stepCounts: [Int] = []
    var days: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //progressTrackBar for more clarity
        self.view.backgroundColor = .homepageBackground
        requestAuthorization()
        
        //when user has been already done today, we need to validate this
        questionConfirmView.isHidden = true
        
        dayArry = [sundayDate: [sundayView: sundayLabel], mondayDate: [mondayView: mondayLabel], tuesdayDate: [tuesdayView: tuesdayLabel], wednesdayDate: [wednesdayView: wednesdayLabel], thursdayDate: [thursdayView: thursdayLabel], fridayDate: [fridayView: fridayLabel], saturdayDate: [saturdayView: saturdayLabel]]
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView], with: .homepageStroke, backgroundColor: .white)
        applyBoader([questionBannerView, testView, myDiaryView, chartContainerView], with: .homepageStroke, backgroundColor: .white)
        
        dateSettingForWeekday([sundayDate, mondayDate, tuesdayDate, wednesdayDate, thursdayDate, fridayDate, saturdayDate])
        updateTodayView()
        // Navigation
        tapAction(testView, selector: #selector(displaySurveyListViewController))
        tapAction(myDiaryView, selector: #selector(displayMyDiaryViewController))
        setUpMyRecentMood()
        setupChart()
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
            sundayEmoji.image = mood.moodImage
        case 2:
            mondayEmoji.image = mood.moodImage
        case 3:
            tuesdayEmoji.image = mood.moodImage
        case 4:
            wednesdayEmoji.image = mood.moodImage
        case 5:
            thursdayEmoji.image = mood.moodImage
        case 6:
            fridayEmoji.image = mood.moodImage
        case 7:
            saturdayEmoji.image = mood.moodImage
        default :
            break
        }
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
    
    func getQuestionLabelText() -> String {
        // can be fetch data from backend
        return "Was dopamine detox successful?"
    }
    
    func setupImageSubscriber(publisher: PassthroughSubject<UIImage, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newImage in
                //TODO: Need to do proper mapping
                self?.tuesdayEmoji.image = newImage
            }
            .store(in: &cancellables)
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

extension HomeViewController {
    func requestAuthorization() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let healthKitTypes: Set = [stepType]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) { (success, error) in
            if success {
                self.fetchStepCounts()
            } else {
                print("Authorization failed")
            }
        }
    }
    
    private func setupChart() {
        // Customize x-axis
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.labelCount = 14
        //xAxis.valueFormatter = DateValueFormatter() // Custom x-axis labels (dates)

        // Customize y-axis (left)
        let leftAxis = barChartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.drawGridLinesEnabled = true
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawAxisLineEnabled = false

        // Customize y-axis (right)
        let rightAxis = barChartView.rightAxis
        rightAxis.enabled = false

        // Customize chart description
        barChartView.chartDescription.enabled = false
        barChartView.legend.enabled = true
        
        // Customize additional chart settings
        barChartView.setScaleEnabled(false)
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        
        class DateValueFormatter: NSObject, AxisValueFormatter {
            
            let dates: [String] = ["6/1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]
            
            func stringForValue(_ value: Double, axis: AxisBase?) -> String {
                return dates[Int(value)]
            }
        }
    }
    
    func updateChart() {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<stepCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(stepCounts[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Steps")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.granularity = 1
    }
    
    func processStepCounts(statsCollection: HKStatisticsCollection) {
        let calendar = Calendar.current
        let now = Date()
        let endDate = calendar.startOfDay(for: now)
        
        var dateComponents = DateComponents()
        dateComponents.day = -13
        let startDate = calendar.date(byAdding: dateComponents, to: endDate)!
        
        statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            let stepCount = statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0
            let date = statistics.startDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            let dateString = dateFormatter.string(from: date)
            
            self.stepCounts.append(Int(stepCount))
            self.days.append(dateString)
        }
        
        DispatchQueue.main.async {
            self.updateChart()
        }
    }

    func fetchStepCounts() {
        let calendar = Calendar.current
        let now = Date()
        var dateComponents = DateComponents()
        dateComponents.calendar = calendar
        
        let endDate = calendar.startOfDay(for: now)
        dateComponents.day = -13
        let startDate = calendar.date(byAdding: dateComponents, to: endDate)!
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let query = HKStatisticsCollectionQuery(
            quantityType: stepType,
            quantitySamplePredicate: predicate,
            options: [.cumulativeSum],
            anchorDate: startDate,
            intervalComponents: DateComponents(day: 1)
        )
        
        query.initialResultsHandler = { query, results, error in
            if let statsCollection = results {
                self.processStepCounts(statsCollection: statsCollection)
            }
        }
        
        let queryForToday = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
             if let result = result, let sum = result.sumQuantity() {
                 let steps = Int(sum.doubleValue(for: HKUnit.count()))
                 DispatchQueue.main.async {
                     self.setCountLabel.text = "\(steps)"
                 }
             } else {
                 print("Error while fetching step count: \(error?.localizedDescription ?? "Unknown error")")
             }
         }
        //TODO: Need to re-visit
        healthStore.execute(queryForToday)
        
        healthStore.execute(query)
    }
}

//
//  SurveyResultViewController.swift
//  MentalHealth
//
//  Created by Yoon on 4/11/24.
//

import UIKit

class SurveyResultViewController: UIViewController {
    
    @IBOutlet var chart: TKRadarChart! {
        didSet{
            chart.configuration.borderWidth = 1
            chart.configuration.lineWidth = 3
            chart.configuration.showBorder = true
            chart.configuration.showBgLine = true
        }
    }
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.hidesWhenStopped = true
        }
    }
    // Image Views
    @IBOutlet var depressionImageView: UIImageView!
    @IBOutlet var anxietyImageView: UIImageView!
    @IBOutlet var stressImageView: UIImageView!
    @IBOutlet var socialMediaAddictionImageView: UIImageView!
    @IBOutlet var lonelinessImageView: UIImageView!
    @IBOutlet var hrqolImageView: UIImageView!

    // Title Labels
    @IBOutlet var depressionTitleLabel: UILabel!
    @IBOutlet var anxietyTitleLabel: UILabel!
    @IBOutlet var stressTitleLabel: UILabel!
    @IBOutlet var socialMediaAddictionTitleLabel: UILabel!
    @IBOutlet var lonelinessTitleLabel: UILabel!
    @IBOutlet var hrqolTitleLabel: UILabel!

    // Personal Score Labels
    @IBOutlet var depressionMyScoreLabel: UILabel!
    @IBOutlet var anxietyMyScoreLabel: UILabel!
    @IBOutlet var stressMyScoreLabel: UILabel!
    @IBOutlet var socialMediaAddictionMyScoreLabel: UILabel!
    @IBOutlet var lonelinessMyScoreLabel: UILabel!
    @IBOutlet var hrqolMyScoreLabel: UILabel!
        
    // Average Score Labels
    @IBOutlet var depressionAverageScoreLabel: UILabel!
    @IBOutlet var anxietyAverageScoreLabel: UILabel!
    @IBOutlet var stressAverageScoreLabel: UILabel!
    @IBOutlet var socialMediaAddictionAverageScoreLabel: UILabel!
    @IBOutlet var lonelinessAverageScoreLabel: UILabel!
    @IBOutlet var hrqolAverageScoreLabel: UILabel!
    
    
// DangerView
    @IBOutlet var dangerLabel: UILabel!
    @IBOutlet var warningView: UIView!
    @IBOutlet var warningTextView: UITextView!
    @IBOutlet var dangerView: DangerView!
    
    @IBOutlet var meLabel: UILabel!
    @IBOutlet var avgLabel: UILabel!
    
    var myTestScore: [Int:Int] = [:]
    var allUsersAverageResult: [Int: Int] = [ : ]
    let categories = [0: "Depression", 
                      5: "Anxiety",
                      10: "Stress",
                      15: "Social Media Addiction",
                      20: "Loneliness",
                      25: "HRQOL"]
    var shouldHideData = false
    var scoreResults: [Int: [Double]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Test Result"
        self.imageSetup()
        self.labelSetup()
        self.fetchUsersAverageResult()
        self.setupWarningView()
    }
    
    private func setupWarningView() {
        warningView.backgroundColor = .surveyWarningBackgroundColor
        warningView.addBorderAndColor(color: .surveyWarningBackgroundColor, width: 1, corner_radius: 12)
        warningTextView.font = .boldFont12
        warningTextView.textColor = .surveyWaningLabelColor
        warningTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    private func fetchUsersAverageResult() {
        self.activityIndicator.startAnimating()
        FBNetworkLayer.shared.getAllSurveyResult { result in
            guard self == self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let testResults):
                    self.remappingTestAverageScore(allTestResults: testResults)
                    self.setupScoreResult()
                    self.chartSetup()
                    self.labelResultSetup()
                    self.activityIndicator.stopAnimating()
                case .failure( _):
                    self.showAlert(error: .fetchingTestScoreFails)
                }
            }
        }
    }
    
    private func remappingTestAverageScore(allTestResults: [SurveyResult]) {
        var scoreSums: [Int: Int] = [:]
        var scoreCounts: [Int: Int] = [:]
            
        for result in allTestResults {
            for (index, score) in result.surveyAnswer.enumerated() {
                scoreSums[index, default: 0] += score
                scoreCounts[index, default: 0] += 1
            }
        }
        
        var allUsersAverageResult: [Int: Int] = [:]
        for (index, totalScore) in scoreSums {
            let count = scoreCounts[index] ?? 1
            allUsersAverageResult[index] = totalScore / count
        }
        
        self.allUsersAverageResult = allUsersAverageResult
        print("allUsersAverageResult \(self.allUsersAverageResult)")
    }
        
    private func stringForValue(_ index: Int) -> String {
            switch index {
            case 0:
                return "Depression"
            case 1:
                return "Anxiety"
            case 2:
                return "Stress"
            case 3:
                return "Social Media Addiction \n (SMA)"
            case 4:
                return "Loneliness"
            case 5:
                return "HRQOL"
            default:
                return ""
            }
        }

    private func imageSetup() {
        depressionImageView.image = UIImage(assetIdentifier: .depressionIcon)
        anxietyImageView.image = UIImage(assetIdentifier: .anxietyIcon)
        stressImageView.image = UIImage(assetIdentifier: .stressIcon)
        socialMediaAddictionImageView.image = UIImage(assetIdentifier: .socialmediaIcon)
        lonelinessImageView.image = UIImage(assetIdentifier: .lonelinessIcon)
        hrqolImageView.image = UIImage(assetIdentifier: .hrqolIcon)
    }
    
    private func setupScoreResult() {
        
        scoreResults[0] = []
        scoreResults[1] = []
        for (startKey, _) in categories {
            let range = startKey..<startKey + 5
            let sum1 = range.reduce(0) { $0 + (myTestScore[$1] ?? 0) }
            let sum2 = range.reduce(0) { $0 + (allUsersAverageResult[$1] ?? 0) }
            let myAvg1 = Double(sum1) / 5.0
            let allAvg1 = Double(sum2) / 5.0
            scoreResults[0]?.append(myAvg1)
            scoreResults[1]?.append(allAvg1)
        }
    }
    private func labelSetup() {
        stackView.addBorder(toSide: .top, withColor: .surveyStackBorder, andThickness: 1)
        depressionTitleLabel.font = .boldFont16
        anxietyTitleLabel.font = .boldFont16
        stressTitleLabel.font = .boldFont16
        socialMediaAddictionTitleLabel.font = .boldFont16
        lonelinessTitleLabel.font = .boldFont16
        hrqolTitleLabel.font = .boldFont16
        dangerLabel.font = .boldFont12
        meLabel.font = .boldFont12
        avgLabel.font = .boldFont12
        avgLabel.textColor = .surveyAvgTitle
    }
    
    private func colorMapping(myScore: Double, averageScore: Double) -> UIColor {
        if myScore > averageScore {
            return .surveyResultRed
        }
        else if myScore < averageScore {
            return .surveyResultGreen
        }
        return .black
    }
    
    private func labelResultSetup() {
        
        for (startKey, category) in categories {
            let range = startKey..<startKey + 5
            let sum1 = range.reduce(0) { $0 + (myTestScore[$1] ?? 0) }
            let sum2 = range.reduce(0) { $0 + (allUsersAverageResult[$1] ?? 0) }
            let avg1 = Double(sum1) / 5.0
            let avg2 = Double(sum2) / 5.0

            let myScoreString = NSAttributedString(
                string: "\(avg1)",
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 16),
                    .foregroundColor: self.colorMapping(myScore: avg1, averageScore: avg2)
                ]
            )

            let averageScoreString = NSAttributedString(
                string: "\(avg2)",
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 16),
                    .foregroundColor: UIColor.black
                ]
            )
            
            switch category {
            case "Depression":
                depressionMyScoreLabel.attributedText = myScoreString
                depressionAverageScoreLabel.attributedText = averageScoreString
            case "Anxiety":
                anxietyMyScoreLabel.attributedText = myScoreString
                anxietyAverageScoreLabel.attributedText = averageScoreString
            case "Stress":
                stressMyScoreLabel.attributedText = myScoreString
                stressAverageScoreLabel.attributedText = averageScoreString
            case "Social Media Addiction":
                socialMediaAddictionMyScoreLabel.attributedText = myScoreString
                socialMediaAddictionAverageScoreLabel.attributedText = averageScoreString
            case "Loneliness":
                lonelinessMyScoreLabel.attributedText = myScoreString
                lonelinessAverageScoreLabel.attributedText = averageScoreString
            case "HRQOL":
                hrqolMyScoreLabel.attributedText = myScoreString
                hrqolAverageScoreLabel.attributedText = averageScoreString
            default:
                break
            }
        }
    }
    
    private func chartSetup() {
        let w = view.bounds.width
        chart.configuration.radius = w/3
        chart.dataSource = self
        chart.delegate = self
        chart.center = view.center
        chart.reloadData()
        view.addSubview(chart)
    }
    
}

extension SurveyResultViewController: TKRadarChartDataSource, TKRadarChartDelegate, UITableViewDelegate {
    func numberOfStepForRadarChart(_ radarChart: TKRadarChart) -> Int {
//      Max value
        return 5
    }
    func numberOfRowForRadarChart(_ radarChart: TKRadarChart) -> Int {
//      Row value
        return 6
    }
    
    func numberOfSectionForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 2
    }

    func titleOfRowForRadarChart(_ radarChart: TKRadarChart, row: Int) -> String {
        return stringForValue(row)
    }

    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat {
        if let averages = scoreResults[section], row < averages.count {
                return CGFloat(averages[row])
            } else {
                // Return a default value or handle the error as appropriate.
                return 0.0
            }
    }


    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return .gray.withAlphaComponent(0.7)
    }

    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor {
        return UIColor.clear
    }

    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        if section == 0 {
            return .chartMyScoreFill.withAlphaComponent(0.60)
        } else {
            return UIColor.clear
        }
    }

    func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        if section == 0 {
            return UIColor.clear
        } else {
            return .chartAverageBorder
        }
    }

    func colorOfTitleForRadarChart(_ radarChart: TKRadarChart, row: Int) -> UIColor {
        switch row {
        case 0:
            return .depressionColor
        case 1:
            return .anxietyColor
        case 2:
            return .stressColor
        case 3:
            return .socialMediaColor
        case 4:
            return .lonelinessColor
        default:
            return .hrqolColor
        }
    }
    
    func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont {
        return .boldFont12
    }
}

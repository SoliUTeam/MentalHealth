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

    // Score Labels
    @IBOutlet var depressionScoreLabel: UILabel!
    @IBOutlet var anxietyScoreLabel: UILabel!
    @IBOutlet var stressScoreLabel: UILabel!
    @IBOutlet var socialMediaAddictionScoreLabel: UILabel!
    @IBOutlet var lonelinessScoreLabel: UILabel!
    @IBOutlet var hrqolScoreLabel: UILabel!
    
    var myTestScore: [Int:Int] = [:]
    var allUsersAverageResult: [Int: Int] = [ : ]
    let categories = [0: "Depression", 5: "Anxiety", 10: "Stress", 15: "Loneliness", 20: "Social Media Addiction", 25: "HRQOL"]
    var shouldHideData = false
    var scoreResults: [Int: [Double]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupScoreResult()
        self.title = "Test Result"
        self.imageSetup()
        self.labelSetup()
        fetchUsersAverageResult()
    }
    
    private func fetchUsersAverageResult() {
        FBNetworkLayer.shared.getAllSurveyResult { result in
            guard self == self else { return }
            switch result {
            case .success(let testResults):
                self.remappingTestAverageScore(allTestResults: testResults)
                self.setupScoreResult()
                self.chartSetup()
                self.labelResultSetup()
            case .failure(let error):
                self.showAlert(error: .fetchingTestScoreFails)
                
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
        print(allUsersAverageResult)
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
                return "Loneliness"
            case 4:
                return "Addiction"
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
        LabelStyle.surveyResultTitle(color: .depressionColor).apply(to: depressionTitleLabel)
        LabelStyle.surveyResultTitle(color: .anxietyColor).apply(to: anxietyTitleLabel)
        LabelStyle.surveyResultTitle(color: .stressColor).apply(to: stressTitleLabel)
        LabelStyle.surveyResultTitle(color: .socialMediaColor).apply(to: socialMediaAddictionTitleLabel)
        LabelStyle.surveyResultTitle(color: .lonelinessColor).apply(to: lonelinessTitleLabel)
        LabelStyle.surveyResultTitle(color: .hrqolColor).apply(to: hrqolTitleLabel)
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
        var resultTable: [String: NSAttributedString] = [:]
        let blackResultString: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        
        for (startKey, category) in categories {
            let range = startKey..<startKey + 5
            let sum1 = range.reduce(0) { $0 + (myTestScore[$1] ?? 0) }
            let sum2 = range.reduce(0) { $0 + (allUsersAverageResult[$1] ?? 0) }
            let avg1 = Double(sum1) / 5.0
            let avg2 = Double(sum2) / 5.0
            
            let combinedString = NSMutableAttributedString()
            let colorResultString: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 14),
                .foregroundColor: self.colorMapping(myScore: avg1, averageScore: avg2)
            ]
            let partOne = NSAttributedString(string: "\(avg1) : ", attributes: colorResultString)
            let partTwo = NSAttributedString(string: "\(avg2)", attributes: blackResultString)
            
            combinedString.append(partOne)
            combinedString.append(partTwo)

            resultTable[category] = combinedString
        }
        
        
        depressionScoreLabel.attributedText = resultTable["Depression"]
        anxietyScoreLabel.attributedText = resultTable["Anxiety"]
        stressScoreLabel.attributedText = resultTable["Stress"]
        socialMediaAddictionScoreLabel.attributedText = resultTable["Social Media Addiction"]
        lonelinessScoreLabel.attributedText = resultTable["Loneliness"]
        hrqolScoreLabel.attributedText = resultTable["HRQOL"]
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

    func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont {
        return UIFont.boldSystemFont(ofSize: 12)
    }
}

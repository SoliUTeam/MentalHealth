//
//  SurveyResultViewController.swift
//  MentalHealth
//
//  Created by Yoon on 4/11/24.
//

import UIKit
import DGCharts

class SurveyResultViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var chartView: RadarChartView!
    
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
    
    var myTestScore: [Int:Int] = TestingInformation().exampleSurveyList()
    var allUsersAverageResult: [Int: Int] = TestingInformation().exampleAllSurveyDict()
    let categories = [0: "Depression", 5: "Anxiety", 10: "Stress", 15: "Loneliness", 20: "Social Media Addiction", 25: "HRQOL"]
    var shouldHideData = false
    
    
    private func imageSetup() {
        depressionImageView.image = UIImage(assetIdentifier: .depressionIcon)
        anxietyImageView.image = UIImage(assetIdentifier: .anxietyIcon)
        stressImageView.image = UIImage(assetIdentifier: .stressIcon)
        socialMediaAddictionImageView.image = UIImage(assetIdentifier: .socialmediaIcon)
        lonelinessImageView.image = UIImage(assetIdentifier: .lonelinessIcon)
        hrqolImageView.image = UIImage(assetIdentifier: .hrqolIcon)
    }
    
    private func labelSetup() {
        LabelStyle.surveyResultTitle(color: .depressionColor).apply(to: depressionTitleLabel)
        LabelStyle.surveyResultTitle(color: .anxietyColor).apply(to: anxietyTitleLabel)
        LabelStyle.surveyResultTitle(color: .stressColor).apply(to: stressTitleLabel)
        LabelStyle.surveyResultTitle(color: .socialMediaColor).apply(to: socialMediaAddictionTitleLabel)
        LabelStyle.surveyResultTitle(color: .lonelinessColor).apply(to: lonelinessTitleLabel)
        LabelStyle.surveyResultTitle(color: .hrqolColor).apply(to: hrqolTitleLabel)
    }
    
    private func colorMapping(category: String) -> UIColor {
        switch category {
        case "Depression":
            return .depressionColor
        case "Anxiety":
            return .anxietyColor
        case "Stress":
            return .stressColor
        case "Loneliness":
            return .lonelinessColor
        case "Social Media Addiction":
            return .socialMediaColor
        case "HRQOL":
            return .hrqolColor
        default:
            return .black
        }
    }
    
    private func labelResultSetup() {
        var resultTable: [String: NSAttributedString] = [:]
        var blackResultString: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        
        for (startKey, category) in categories {
            let range = startKey..<startKey + 5
            let sum1 = range.reduce(0) { $0 + (myTestScore[$1] ?? 0) }
            let sum2 = range.reduce(0) { $0 + (allUsersAverageResult[$1] ?? 0) }
            let avg1 = Double(sum1) / 5.0
            let avg2 = Double(sum2) / 5.0
            
            var combinedString = NSMutableAttributedString()
            let colorResultString: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 14),
                .foregroundColor: self.colorMapping(category: category)
            ]
            let partOne = NSAttributedString(string: "\(avg1):", attributes: colorResultString)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Radar Chart"
        self.imageSetup()
        self.labelSetup()
        labelResultSetup()
        
        chartView.delegate = self
        
        chartView.chartDescription.enabled = false
        chartView.webLineWidth = 0
        chartView.innerWebLineWidth = 2
        chartView.webColor = .soliuBlack
        chartView.innerWebColor = .lightGray
        chartView.webAlpha = 1
        
        let marker = RadarMarkerView.viewFromXib()!
        marker.chartView = chartView
        chartView.marker = marker
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .black
        
//        let yAxis = chartView.yAxis
//        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
//        yAxis.labelCount = 5
//        yAxis.axisMinimum = 0
//        yAxis.axisMaximum = 5
//        yAxis.drawLabelsEnabled = true
        
        chartView.yAxis.enabled = false
        chartView.legend.enabled = false
        
        
        self.updateChartData()
        chartView.rotationEnabled = false
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
     func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setChartData()
    }
    
    func setChartData() {
        
        var myResultEntry = [RadarChartDataEntry]()
        var averageResultEntry = [RadarChartDataEntry]()

        for (startKey, category) in categories {
            let range = startKey..<startKey + 5
            let sum1 = range.reduce(0) { $0 + (myTestScore[$1] ?? 0) }
            let sum2 = range.reduce(0) { $0 + (allUsersAverageResult[$1] ?? 0) }
            let avg1 = Double(sum1) / 5.0
            let avg2 = Double(sum2) / 5.0
            myResultEntry.append(RadarChartDataEntry(value: avg1))
            averageResultEntry.append(RadarChartDataEntry(value: avg2))
        }
        
        let set1 = RadarChartDataSet(entries: myResultEntry, label: "My Result")
        set1.setColor(.chartBackground)
        set1.fillColor = .chartBackground
        set1.drawFilledEnabled = true
        set1.lineWidth = 2
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        let set2 = RadarChartDataSet(entries: averageResultEntry, label: "Average")
        set2.setColor(.red)
        set2.drawFilledEnabled = false
        set2.lineWidth = 2
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        
        let data: RadarChartData = RadarChartData(dataSets: [set1, set2])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(true)
        data.setValueTextColor(.black)
        
        chartView.data = data
    }
}

extension SurveyResultViewController: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
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
            return "Social Media Addiction"
        case 5:
            return "HRQOL"
        default:
            return ""
        }
    }
}

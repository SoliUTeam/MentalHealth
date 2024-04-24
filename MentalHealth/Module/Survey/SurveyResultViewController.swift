//
//  SurveyResultViewController.swift
//  MentalHealth
//
//  Created by Yoon on 4/11/24.
//

import UIKit
import DGCharts

class SurveyResultViewController: DemoBaseViewController {
    
    @IBOutlet var chartView: RadarChartView!
    
    @IBOutlet var depressionImageView: UIImageView!
    @IBOutlet var depressionTitleLabel: UILabel!
    @IBOutlet var depressionScoreLabel: UILabel!

    @IBOutlet var anxietyImageView: UIImageView!
    @IBOutlet var anxietyTitleLabel: UILabel!
    @IBOutlet var anxietyScoreLabel: UILabel!

    @IBOutlet var stressImageView: UIImageView!
    @IBOutlet var stressTitleLabel: UILabel!
    @IBOutlet var stressScoreLabel: UILabel!

    @IBOutlet var socialMediaAddictionImageView: UIImageView!
    @IBOutlet var socialMediaAddictionTitleLabel: UILabel!
    @IBOutlet var socialMediaAddictionScoreLabel: UILabel!

    @IBOutlet var lonelinessImageView: UIImageView!
    @IBOutlet var lonelinessTitleLabel: UILabel!
    @IBOutlet var lonelinessScoreLabel: UILabel!

    @IBOutlet var hrqolImageView: UIImageView!
    @IBOutlet var hrqolTitleLabel: UILabel!
    @IBOutlet var hrqolScoreLabel: UILabel!
    var myTestScore: [Int:Int] = TestingInformation().exampleSurveyList()
    var allUsersAverageResult: [Int: Int] = TestingInformation().exampleAllSurveyDict()
    
    private func imageSetup() {
        depressionImageView.image = UIImage(assetIdentifier: .depressionIcon)
        anxietyImageView.image = UIImage(assetIdentifier: .anxietyIcon)
        stressImageView.image = UIImage(assetIdentifier: .stressIcon)
        socialMediaAddictionImageView.image = UIImage(assetIdentifier: .socialmediaIcon)
        lonelinessImageView.image = UIImage(assetIdentifier: .lonelinessIcon)
        hrqolImageView.image = UIImage(assetIdentifier: .hrqolIcon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Radar Chart"
        self.imageSetup()
        
        //        self.options = [.toggleValues,
        //                        .toggleHighlight,
        //                        .toggleHighlightCircle,
        //                        .toggleXLabels,
        //                        .toggleYLabels,
        //                        .toggleRotate,
        //                        .toggleFilled,
        //                        .animateX,
        //                        .animateY,
        //                        .animateXY,
        //                        .spin,
        //                        .saveToGallery,
        //                        .toggleData]
        
        chartView.delegate = self
        
        chartView.chartDescription.enabled = false
        chartView.webLineWidth = 2
        chartView.innerWebLineWidth = 1
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
        
//        let l = chartView.legend
//        l.horizontalAlignment = .left
//        l.verticalAlignment = .bottom
//        l.orientation = .horizontal
//        l.drawInside = false
//        l.font = .systemFont(ofSize: 10, weight: .light)
//        l.xEntrySpace = 50
//        l.yEntrySpace = 50
//        l.textColor = .black
        //        chartView.legend = l
        
        self.updateChartData()
        chartView.rotationEnabled = false
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setChartData()
    }
    
    func setChartData() {
        let categories = [0: "Depression", 5: "Anxiety", 10: "Stress", 15: "Loneliness", 20: "Social Media Addiction", 25: "HRQOL"]
        
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
    
    override func optionTapped(_ option: Option) {
        guard let data = chartView.data else { return }
        
        //        switch option {
        //        case .toggleXLabels:
        //            chartView.xAxis.drawLabelsEnabled = !chartView.xAxis.drawLabelsEnabled
        //            chartView.data?.notifyDataChanged()
        //            chartView.notifyDataSetChanged()
        //            chartView.setNeedsDisplay()
        //
        //        case .toggleYLabels:
        //            chartView.yAxis.drawLabelsEnabled = !chartView.yAxis.drawLabelsEnabled
        //            chartView.setNeedsDisplay()
        //
        //        case .toggleRotate:
        //            chartView.rotationEnabled = !chartView.rotationEnabled
        //
        //        case .toggleFilled:
        //            for case let set as RadarChartDataSet in data {
        //                set.drawFilledEnabled = !set.drawFilledEnabled
        //            }
        //
        //            chartView.setNeedsDisplay()
        //
        //        case .toggleHighlightCircle:
        //            for case let set as RadarChartDataSet in data {
        //                set.drawHighlightCircleEnabled = !set.drawHighlightCircleEnabled
        //            }
        //            chartView.setNeedsDisplay()
        //
        //        case .animateX:
        //            chartView.animate(xAxisDuration: 1.4)
        //
        //        case .animateY:
        //            chartView.animate(yAxisDuration: 1.4)
        //
        //        case .animateXY:
        //            chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
        //
        //        case .spin:
        //            chartView.spin(duration: 2, fromAngle: chartView.rotationAngle, toAngle: chartView.rotationAngle + 360, easingOption: .easeInCubic)
        //
        //        default:
        //            super.handleOption(option, forChartView: chartView)
        //        }
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

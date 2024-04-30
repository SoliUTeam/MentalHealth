//
//  SurveyListCell.swift
//  MentalHealth
//
//  Created by Yoon on 3/31/24.
//

import Foundation
import UIKit

class SurveyListViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet var surveyQuestionLabel: UILabel! {
        didSet {
            surveyQuestionLabel.font = .surveyQuestionTitle
        }
    }
    
    @IBOutlet var surveyAnswerLabel1: UILabel! {
        didSet{
            surveyAnswerLabel1.font = .surveyAnswerFont
        }
    }
    @IBOutlet var surveyAnswerLabel2: UILabel! {
        didSet{
            surveyAnswerLabel2.font = .surveyAnswerFont
        }
    }
    @IBOutlet var surveyAnswerLabel3: UILabel! {
        didSet{
            surveyAnswerLabel3.font = .surveyAnswerFont
        }
    }
    @IBOutlet var surveyAnswerLabel4: UILabel! {
        didSet{
            surveyAnswerLabel4.font = .surveyAnswerFont
        }
    }
    @IBOutlet var surveyAnswerLabel5: UILabel! {
        didSet{
            surveyAnswerLabel5.font = .surveyAnswerFont
        }
    }
    
    @IBOutlet var surveyAnswerImage1: UIImageView!
    @IBOutlet var surveyAnswerImage2: UIImageView!
    @IBOutlet var surveyAnswerImage3: UIImageView!
    @IBOutlet var surveyAnswerImage4: UIImageView!
    @IBOutlet var surveyAnswerImage5: UIImageView!
    
    private var imageMappings: [UIImageView: (unmarked: UIImage?, marked: UIImage?)] = [:]
    private var testQuestion: TestQuestion?
    private var selectedValue: Int?
    weak var delegate: SurveyListViewCellDelegate?

    
    func populate(testQuestion: TestQuestion) {
        self.testQuestion = testQuestion
        surveyQuestionLabel.text = testQuestion.question
        setupSureyAnswer(testQuestion.questionNumber)
        
    }
    
    private func setupSureyAnswer(_ testquestionNumber: Int) {
        switch testquestionNumber {
        case 25:
            surveyAnswerLabel1.text = "Poor"
            surveyAnswerLabel2.text = "Fair"
            surveyAnswerLabel3.text = "Good"
            surveyAnswerLabel4.text = "Very good"
            surveyAnswerLabel5.text = "Excellent"
            
        case 26...29:
            surveyAnswerLabel1.text = "Very frequently\n(21-30 days)"
            surveyAnswerLabel2.text = "Frequently\n(11-20 days)"
            surveyAnswerLabel3.text = "Occasionally\n(6-10 days)"
            surveyAnswerLabel4.text = "Rarely\n(1-5 days)"
            surveyAnswerLabel5.text = "Never\n(0 days)"
        default:
            surveyAnswerLabel1.text = "Very Rarely"
            surveyAnswerLabel2.text = "Rarely"
            surveyAnswerLabel3.text = "Sometimes"
            surveyAnswerLabel4.text = "Often"
            surveyAnswerLabel5.text = "Very Often"
        }
    }

    private func setupImageMappings() {
        imageMappings[surveyAnswerImage1] = (UIImage(assetIdentifier: .unmarkedVRare), UIImage(assetIdentifier: .markedVRare))
        imageMappings[surveyAnswerImage2] = (UIImage(assetIdentifier: .unmarkedRare), UIImage(assetIdentifier: .markedRare))
        imageMappings[surveyAnswerImage3] = (UIImage(assetIdentifier: .unmarkedSometimes), UIImage(assetIdentifier: .markedSometimes))
        imageMappings[surveyAnswerImage4] = (UIImage(assetIdentifier: .unmarkedOften), UIImage(assetIdentifier: .markedVOften)) // Assuming you meant 'markedVOften' for the marked state of 'unmarkedOften'
        imageMappings[surveyAnswerImage5] = (UIImage(assetIdentifier: .unmarkedVOften), UIImage(assetIdentifier: .markedVOften))
    }
    
    private var surveyImageView: [UIImageView] {
            return [surveyAnswerImage1, surveyAnswerImage2, surveyAnswerImage3, surveyAnswerImage4, surveyAnswerImage5]
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupGestureRecognizers()
        initialImageSetup()
        setupImageMappings()
    }
    
    private func initialImageSetup() {
        surveyAnswerImage1.image = UIImage(assetIdentifier:.unmarkedVRare)
        surveyAnswerImage2.image = UIImage(assetIdentifier:.unmarkedRare)
        surveyAnswerImage3.image = UIImage(assetIdentifier:.unmarkedSometimes)
        surveyAnswerImage4.image = UIImage(assetIdentifier:.unmarkedOften)
        surveyAnswerImage5.image = UIImage(assetIdentifier:.unmarkedVOften)
    }
    
    func resetImagesToUnmarked() {
        surveyImageView.forEach { imageView in
            if let unmarkedImage = imageMappings[imageView]?.unmarked {
                imageView.image = unmarkedImage
            }
        }
    }
    
    private func setupGestureRecognizers() {
        surveyImageView.forEach { imageView in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let selectedImageView = sender.view as? UIImageView else { return }
        guard let testQuestion = testQuestion else { return }
        if let selectedIndex = surveyImageView.firstIndex(of: selectedImageView) {
                selectedValue = selectedIndex
                delegate?.mappingSelectedValue(id: testQuestion.id, questionNumber: testQuestion.questionNumber, value:selectedIndex)
                print("Selected Image \(selectedValue)")
                resetImages(except: selectedImageView)
           }
    }
    
    private func resetImages(except selectedImageView: UIImageView) {
        surveyImageView.forEach { imageView in
            if imageView == selectedImageView {
                if let markedImage = imageMappings[imageView]?.marked {
                    imageView.image = markedImage
                }
            } else {
                if let unmarkedImage = imageMappings[imageView]?.unmarked {
                    imageView.image = unmarkedImage
                }
            }
        }
    }
}

protocol SurveyListViewCellDelegate: AnyObject {
    func mappingSelectedValue(id: Int, questionNumber: Int , value: Int)
}


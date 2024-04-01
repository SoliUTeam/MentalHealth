//
//  SurveyListCell.swift
//  MentalHealth
//
//  Created by Yoon on 3/31/24.
//

import Foundation
import UIKit

class SurveyListViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet var surveyQuestionLabel: UILabel!
    @IBOutlet var surveyAnswerImage1: UIImageView!
    @IBOutlet var surveyAnswerImage2: UIImageView!
    @IBOutlet var surveyAnswerImage3: UIImageView!
    @IBOutlet var surveyAnswerImage4: UIImageView!
    @IBOutlet var surveyAnswerImage5: UIImageView!
    
    private var imageViews: [UIImageView] {
            return [surveyAnswerImage1, surveyAnswerImage2, surveyAnswerImage3, surveyAnswerImage4, surveyAnswerImage5]
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGestureRecognizers()
        
    }
    
    private func setupGestureRecognizers() {
        imageViews.forEach { imageView in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let selectedImageView = sender.view as? UIImageView else { return }
        resetImages()
        
        // Highlight the selected image
        selectedImageView.image = UIImage(named: "your_selected_image_name")
    }
    
    private func resetImages() {
        imageViews.forEach { imageView in
            imageView.image = UIImage(named: "your_default_image_name")
        }
    }
    
    func populate(surveyQuestion: String) {
        surveyQuestionLabel.text = surveyQuestion
    }
}

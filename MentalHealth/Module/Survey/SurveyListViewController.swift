//
//  SurveyListDetailViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/4/24.
//

import Foundation
import UIKit
import Hero

class SurveyListDetailViewController: UIViewController {
    
    var testInfoArray: [TestQuestion] = []
    var testAnswers: [Int] = []
    @IBOutlet private var questionsLabel: UILabel!
    
    
    lazy var fbLayer = FBNetworkLayer()
    var selectedIndex = 0
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHeroEnabled = true
        fetchQuestions()
    }
    
    @IBAction func surveyButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        var answerNumber = sender.tag
        testAnswers.append(answerNumber)
        nextButtonTapped()
    }
    
    private func fetchQuestions() {
            fbLayer.fetchMentalHealthQuestions { [weak self] healthQuestion, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error fetching questions: \(error)")
                        self.questionsLabel.text = "Error fetching questions"
                        return
                    }
                    self.testInfoArray = healthQuestion?.testQuestions ?? []
                    self.displayQuestion()
                }
            }
        }
        
       func nextButtonTapped() {
            if selectedIndex < testInfoArray.count - 1 {
                selectedIndex += 1
            } else {
                selectedIndex = 0 // Reset to first question if we've reached the end
            }
            displayQuestion()
        }
    
    @IBAction func submitResult() {
        let testUser1 = User(
            demographicInformation: DemographicInfo(gender: "Female", firstName: "Jane", lastName: "Doe"),
            surveyResult: [
                SurveyResult(surveyDate: "2024-03-27", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
                SurveyResult(surveyDate: "2024-03-28", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
                SurveyResult(surveyDate: "2024-03-29", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
            ]
        )
        fbLayer.fetchUserInformation(userInfo: testUser1) { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    print("Error submit getting error: \(error)")
                    return
                }
            }
            print("Fetch")
        }
        
        fbLayer.fetchMentalHealthQuestions { [weak self] healthQuestion, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching questions: \(error)")
                    self.questionsLabel.text = "Error fetching questions"
                    return
                }
                self.testInfoArray = healthQuestion?.testQuestions ?? []
                self.displayQuestion()
            }
        }
    }
        
        private func displayQuestion() {
            guard !testInfoArray.isEmpty else {
                questionsLabel.text = "Question is Empty"
                return
            }
            questionsLabel.text = testInfoArray[selectedIndex].question
        }
}

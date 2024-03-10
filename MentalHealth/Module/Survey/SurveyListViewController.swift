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
    
    @IBOutlet private var questionsLabel: UILabel!
    
    
    lazy var fbLayer = FBNetworkLayer()
    var selectedIndex = 0
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHeroEnabled = true
        fetchQuestions()
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
        
        @IBAction private func nextButtonTapped() {
            if selectedIndex < testInfoArray.count - 1 {
                selectedIndex += 1
            } else {
                selectedIndex = 0 // Reset to first question if we've reached the end
            }
            displayQuestion()
        }
        
        private func displayQuestion() {
            guard !testInfoArray.isEmpty else {
                questionsLabel.text = "Question is Empty"
                return
            }
            questionsLabel.text = testInfoArray[selectedIndex].question
        }
}

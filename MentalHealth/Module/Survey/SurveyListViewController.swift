//
//  SurveyListDetailViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/4/24.
//

import Foundation
import UIKit

class SurveyListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }


    var surveyQuestion: [TestQuestion] = []
    var testAnswers: [Int] = []
    var selectedQuestionType = 0
    
    lazy var fbLayer = FBNetworkLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        self.tableView.register(UINib(nibName: SurveyListViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveyListViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: SurveyNextButtonCell.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: SurveyNextButtonCell.reuseIdentifier)
        self.title = ""
    }
    
    @IBAction func nextButtonPressed() {
        selectedQuestionType = selectedQuestionType + 1
       
    }
    

    
    @IBAction func submitResult() {
        print("Submit")
//            let testUser1 = User(
//                demographicInformation: DemographicInfo(gender: "Female", firstName: "Jane", lastName: "Doe"),
//                surveyResult: [
//                    SurveyResult(surveyDate: "2024-03-27", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
//                    SurveyResult(surveyDate: "2024-03-28", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
//                    SurveyResult(surveyDate: "2024-03-29", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
//                ]
//            )
//            fbLayer.fetchUserInformation(userInfo: testUser1) { [weak self] error in
//                guard let self = self else { return }
//                DispatchQueue.main.async {
//                    if let error = error {
//                        print("Error submit getting error: \(error)")
//                        return
//                    }
//                }
//                print("Fetch")
//            }
//    
//            fbLayer.fetchMentalHealthQuestions { [weak self] healthQuestion, error in
//                guard let self = self else { return }
//                DispatchQueue.main.async {
//                    if let error = error {
//                        print("Error fetching questions: \(error)")
//                        self.questionsLabel.text = "Error fetching questions"
//                        return
//                    }
//                    self.testInfoArray = healthQuestion?.testQuestions ?? []
//                    self.displayQuestion()
//                }
//            }
        }
//    @IBAction func surveyButtonPressed(_ sender: UIButton) {
//        print(sender.tag)
//        var answerNumber = sender.tag
//        testAnswers.append(answerNumber)
//        nextButtonTapped()
//    }
    
    private func fetchQuestions() {
    surveyQuestion = TestingInformation().createTestingSurveyQuestion()
    tableView.reloadData()
        
//  Later work on.
//            fbLayer.fetchMentalHealthQuestions { [weak self] healthQuestion, error in
//                guard let self = self else { return }
//                DispatchQueue.main.async {
//                    if let error = error {
//                        print("Error fetching questions: \(error)")
//                        self.questionsLabel.text = "Error fetching questions"
//                        return
//                    }
//                    self.testInfoArray = healthQuestion?.testQuestions ?? []
//                    self.displayQuestion()
//                }
//            }
        }
        
//       func nextButtonTapped() {
//            if selectedIndex < testInfoArray.count - 1 {
//                selectedIndex += 1
//            } else {
//                selectedIndex = 0 // Reset to first question if we've reached the end
//            }
//            displayQuestion()
//        }
    
//    @IBAction func submitResult() {
//        let testUser1 = User(
//            demographicInformation: DemographicInfo(gender: "Female", firstName: "Jane", lastName: "Doe"),
//            surveyResult: [
//                SurveyResult(surveyDate: "2024-03-27", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
//                SurveyResult(surveyDate: "2024-03-28", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
//                SurveyResult(surveyDate: "2024-03-29", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
//            ]
//        )
//        fbLayer.fetchUserInformation(userInfo: testUser1) { [weak self] error in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("Error submit getting error: \(error)")
//                    return
//                }
//            }
//            print("Fetch")
//        }
//        
//        fbLayer.fetchMentalHealthQuestions { [weak self] healthQuestion, error in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("Error fetching questions: \(error)")
//                    self.questionsLabel.text = "Error fetching questions"
//                    return
//                }
//                self.testInfoArray = healthQuestion?.testQuestions ?? []
//                self.displayQuestion()
//            }
//        }
//    }
//        
//        private func displayQuestion() {
//            guard !testInfoArray.isEmpty else {
//                questionsLabel.text = "Question is Empty"
//                return
//            }
//            questionsLabel.text = testInfoArray[selectedIndex].question
//        }
}
extension SurveyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

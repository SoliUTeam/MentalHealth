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


    var allSurveyQuestion: [TestQuestion] = []
    var selectedSurveyQuestion: [TestQuestion] = []
    var testAnswers: [Int] = []
    var selectedQuestionId: Int = 0
    var readyToSubmit = false
    var surveyResultRecord:[Int: Int] = [:]
    lazy var fbLayer = FBNetworkLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        self.tableView.register(UINib(nibName: SurveyListViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveyListViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: SurveyNextButtonCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveyNextButtonCell.reuseIdentifier)
        
        self.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func nextButtonPressed() {
        selectedQuestionId = selectedQuestionId + 1
        if selectedQuestionId == 4 {
            readyToSubmit = true
        }
        reorderQuestion()
        
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
    private func reorderQuestion() {
        selectedSurveyQuestion = allSurveyQuestion.filter { testQuestion in
             selectedQuestionId == testQuestion.id
        }
        tableView.reloadData()
    }
    private func fetchQuestions() {
        allSurveyQuestion = TestingInformation().createTestingSurveyQuestion()
        reorderQuestion()
    }
        

}
extension SurveyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSurveyQuestion.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row  == selectedSurveyQuestion.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SurveyNextButtonCell.reuseIdentifier) as? SurveyNextButtonCell else {
                return UITableViewCell()
            }
            cell.populate(readySubmit: readyToSubmit)
            return cell
        }
        
        else {
            let testQuestion = self.selectedSurveyQuestion[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SurveyListViewCell.reuseIdentifier, for: indexPath) as? SurveyListViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.populate(testQuestion: testQuestion)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let surveyResultVC = storyboard.instantiateViewController(identifier: "SurveyResultViewController") as? SurveyResultViewController {
                navigationController?.pushViewController(surveyResultVC, animated: true)
            } else {
                print("Can't find storyboard")
            }
        
        
//        if surveyResultRecord.count != 5 {
//            readyToSubmit = true
//        }
//        if indexPath.row == selectedSurveyQuestion.count {
//            nextButtonPressed()
//        }
//        
//        if readyToSubmit == true && indexPath.row  == selectedSurveyQuestion.count  {
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                if let surveyResultVC = storyboard.instantiateViewController(identifier: "SurveyResultViewController") as? SurveyResultViewController {
//                    navigationController?.pushViewController(surveyResultVC, animated: true)
//                } else {
//                    print("Can't find storyboard")
//                }
//        }
//        return
    }
}
extension SurveyListViewController: SurveyListViewCellDelegate {
    func mappingSelectedValue(questionID: Int , value: Int) {
        surveyResultRecord[questionID] = value
        print("Value Notified \(surveyResultRecord)")
    }
}




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
//        }
        
//        }

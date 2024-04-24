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
    var surveyResultRecord: [Int: Int] = [:]
    lazy var fbLayer = FBNetworkLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        setCustomBackNavigationButton()
        self.tableView.register(UINib(nibName: SurveyListViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveyListViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: SurveyNextButtonCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveyNextButtonCell.reuseIdentifier)
        updateTitle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func updateTitle() {

        var title = ""
        switch selectedQuestionId {
        case 0:
            title = "Test \(selectedQuestionId + 1): Depression"
        case 1:
            title = "Test \(selectedQuestionId + 1): Anxiety"
        case 2:
            title = "Test \(selectedQuestionId + 1): Stress"
        case 3:
            title = "Test \(selectedQuestionId + 1): Loneliness"
        case 4:
            title = "Test \(selectedQuestionId + 1): Social Media Addiction"
        case 5:
            title = "Test \(selectedQuestionId + 1): HRQOL"
        default:
            title = ""
            
        }
        self.title = title
    }
    
    private func nextButtonPressed() {
        if selectedQuestionId == 4 {
            return
        }
        selectedQuestionId = selectedQuestionId + 1
        if selectedQuestionId == 4 {
            readyToSubmit = true
        }
        reorderQuestion()
        updateTitle()
        tableView.reloadData()
        resetAllCellImages()
    }
    

    
    @IBAction func submitResult() {
        print("Submit")
    }
    
    
    private func reorderQuestion() {
        selectedSurveyQuestion = allSurveyQuestion.filter { testQuestion in
             selectedQuestionId == testQuestion.id
        }
        
        tableView.reloadData()
    }
    
    private func resetAllCellImages() {
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? SurveyListViewCell {
                cell.resetImagesToUnmarked()
            }
        }
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
            cell.delegate = self
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

}
extension SurveyListViewController: SurveyListViewCellDelegate {
    func mappingSelectedValue(id: Int, questionNumber: Int , value: Int) {
        surveyResultRecord[questionNumber] = value
        tableView.reloadRows(at: [IndexPath(row: selectedSurveyQuestion.count, section: 0)], with: .none)
    }
}

extension SurveyListViewController: SurveyNextButtonCellDelegate {
    func nextButtonClicked() {
        self.nextButtonPressed()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let surveyResultVC = storyboard.instantiateViewController(identifier: "SurveyResultViewController") as? SurveyResultViewController {
//            surveyResultVC.myTestScore = surveyResultRecord
//          Example Testing
            surveyResultVC.myTestScore =  TestingInformation().exampleSurveyList()
            navigationController?.pushViewController(surveyResultVC, animated: true)
            
        } else {
            print("Can't find storyboard")
        }
    }
        
////      Display SurveyListViewController
//        if surveyResultRecord.count == 25 { // Make sure all questions are answered
//                self.submitResult()
//                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                if let surveyResultVC = storyboard.instantiateViewController(identifier: "SurveyResultViewController") as? SurveyResultViewController {
//                    surveyResultVC.myTestResult = surveyResultRecord
//                    navigationController?.pushViewController(surveyResultVC, animated: true)
//                    
//                } else {
//                    print("Can't find storyboard")
//                }
//            } else {
//                print("Survey not complete")
//            }
//    }
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

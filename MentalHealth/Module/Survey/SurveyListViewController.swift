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
    var surveyResultArray: [Int] = []
    var selectedQuestionId: Int = 0
    var readyToSubmit = false
    var surveyResultRecord: [Int: Int] = [:]
    var userInfomration: UserInformation = LoginManager.shared.getUserInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        setCustomBackNavigationButton()
        tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: SurveyListViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveyListViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: SurveyNextButtonCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveyNextButtonCell.reuseIdentifier)
        updateTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeNavigationBar()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetNavigationBar()
    }

    private func customizeNavigationBar() {
        navigationController?.navigationBar.barTintColor = .testNavigationBar
        navigationController?.navigationBar.tintColor = .soliuBlack
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.soliuBlack]
        navigationController?.navigationBar.backgroundColor = .testNavigationBar
        let backButtonImage = UIImage(assetIdentifier: .whiteBackButton)
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: navigationController!.navigationBar.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
        navigationController?.navigationBar.layer.mask = maskLayer
    }
    
    private func resetNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }

        navigationBar.barTintColor = nil
        navigationBar.tintColor = .soliuBlack
        navigationBar.titleTextAttributes = nil
        navigationBar.backgroundColor = nil
        navigationBar.backIndicatorImage = nil
        navigationBar.backIndicatorTransitionMaskImage = nil
        navigationBar.layer.mask = nil
        navigationBar.topItem?.backBarButtonItem = nil
    }
    
    private func fetchQuestions() {
        allSurveyQuestion = TestingInformation().createTestingSurveyQuestion()
        reorderQuestion()
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
            title = "Test \(selectedQuestionId + 1): Social Media Addiction"
        case 4:
            title = "Test \(selectedQuestionId + 1): Loneliness"
        case 5:
            title = "Test \(selectedQuestionId + 1): HRQOL"
        default:
            title = ""
            
        }
        self.title = title
    }
    
    private func navigateToResultScreen() {
        let surveyAnswersArray = getSurveyResultArray()
        FBNetworkLayer.shared.addSurvey(userInfomration: userInfomration,
                                        newSurveyResult: SurveyResult(surveyDate: getTestDate(),
                                                                      surveyAnswer: surveyAnswersArray)) { error in
            if let error = error {
                print("Fetching Survey Result Fails \(error.localizedDescription)")
            }
            else {
                print("Fetching Survey Result Success")
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let surveyResultVC = storyboard.instantiateViewController(identifier: "SurveyResultViewController") as? SurveyResultViewController {
            surveyResultVC.myTestScore = surveyResultRecord
            navigationController?.pushViewController(surveyResultVC, animated: true)
            
        } else {
            print("Can't find storyboard")
        }
    }
    
    private func nextButtonPressed() {
        selectedQuestionId = selectedQuestionId + 1
        
        if selectedQuestionId < 6 {
            reorderQuestion()
            if selectedQuestionId == 5 {
                readyToSubmit = true
            }
            return
        }
        
        
        if selectedQuestionId == 6 {
            navigateToResultScreen()
        }
    }
    
    private func reorderQuestion() {
        updateTitle()
        resetAllCellImages()
        selectedSurveyQuestion = allSurveyQuestion.filter { testQuestion in
            selectedQuestionId == testQuestion.id
        }
        reloadDataAndScrollToTop()
        tableView.reloadData()
    }
    
    func reloadDataAndScrollToTop() {
        tableView.reloadData()
        DispatchQueue.main.async {
            if self.tableView.numberOfSections > 0 {
                let topIndexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: topIndexPath, at: .top, animated: true)
            }
        }
    }
    
    private func getSurveyResultArray() -> [Int] {
        for i in 0..<30 {
            if let value = surveyResultRecord[i] {
                surveyResultArray.append(value)
            } else {
                surveyResultArray.append(3)
            }
        }
        return surveyResultArray
    }
    
    
    private func resetAllCellImages() {
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? SurveyListViewCell {
                DispatchQueue.main.async {
                    cell.resetImagesToUnmarked(row: i)
                }
            }
        }
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
    }
}

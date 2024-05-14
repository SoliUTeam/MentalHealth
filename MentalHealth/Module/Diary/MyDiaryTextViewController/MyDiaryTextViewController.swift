//
//  MyDiaryTextViewController.swift
//  MentalHealth
//
//  Created by Yoon on 5/14/24.
//

import UIKit

class MyDiaryTextViewController: UIViewController {
    
    @IBOutlet weak var questionLabel1: UILabel!
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var questionLabel3: UILabel!
    
    @IBOutlet weak var questionView1: UIView!
    @IBOutlet weak var questionView2: UIView!
    @IBOutlet weak var questionView3: UIView!

    @IBOutlet weak var answerTextField1: UITextField!
    @IBOutlet weak var answerTextField2: UITextField!
    @IBOutlet weak var answerTextField3: UITextField!
    
    @IBOutlet weak var wholeView1: UIView!
    @IBOutlet weak var wholeView2: UIView!
    @IBOutlet weak var wholeView3: UIView!
    
    @IBOutlet weak var submitButton: AllSubmitButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.setCustomBackNavigationButton()
        submitButton.isEnabled = true
        let wholeViews = [wholeView1, wholeView2, wholeView3]
        for view in wholeViews {
            view?.addBorderAndColor(color: .diaryBorder, width: 2, corner_radius: 8)
        }
        let questionViews = [questionView1, questionView2, questionView3]
        for view in questionViews {
            view?.addBorder(toSide: .Bottom, withColor: .diaryBorder, andThickness: 2)
        }
        self.title = getCurrentMonthAndDate()
    }
    
    @IBAction func handleTextField() {
        
    }
}

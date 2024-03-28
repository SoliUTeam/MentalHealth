//
//  ViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import UIKit
import Hero

class HomeViewController: UIViewController {

    @IBOutlet weak var wiseLabel: UILabel! {
        didSet {
            wiseLabel.animate(newTexts: changeWiseLabelString())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHeroEnabled = true
    }

    func changeWiseLabelString() -> [String] {
        var quoteArray = [String]()
        for text in InspiringQuote.allCases {
            quoteArray.append(text.rawValue)
        }
        return quoteArray
    }
    
    @IBAction func displaySurveyListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let detailViewController = storyboard.instantiateViewController(identifier: "SurveyListDetailViewController") as? SurveyListDetailViewController {
                navigationController?.pushViewController(detailViewController, animated: true)
            } else {
                print("Can't find storyboard")
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


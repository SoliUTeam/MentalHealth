//
//  ViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import UIKit
import Hero

class HomeViewController: UIViewController {

    @IBOutlet weak var surveyButton: UIButton!
    
    @IBOutlet weak var wiseLabel: UILabel! {
        didSet {
            wiseLabel.animate(newTexts: changeWiseLabelString())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHeroEnabled = true
        surveyButton.setImage(.getImage(.survey_black).resizeTo(width: 32, height: 32), for: .normal)
        surveyButton.setImage(.getImage(.survey_white), for: .selected)
    }

    func changeWiseLabelString() -> [String] {
        var quoteArray = [String]()
        for text in InspiringQuote.allCases {
            quoteArray.append(text.rawValue)
        }
        return quoteArray
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


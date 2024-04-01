//
//  SurveyListNextViewCell.swift
//  MentalHealth
//
//  Created by Yoon on 3/31/24.
//

import Foundation
import UIKit

class SurveyNextButtonCell: UITableViewCell, CellReusable {
    @IBOutlet var nextButton: UIButton!
    
    func populate(readySubmit: Bool) {
        if readySubmit == true {
            nextButton.titleLabel?.text = "Submit"
        }
        else {
            nextButton.titleLabel?.text = "Next"
        }
    }
}


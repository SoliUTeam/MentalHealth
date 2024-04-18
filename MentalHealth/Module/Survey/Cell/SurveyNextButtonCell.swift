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
    
    weak var delegate: SurveyNextButtonCellDelegate?
    
    func populate(readySubmit: Bool) {
        nextButton.setTitle(readySubmit ? "Submit" : "Next", for: .normal)

    }
    
    @IBAction func nextButtonClicked() {
        delegate?.nextButtonClicked()
        print("Button Cliced")
    }
}

protocol SurveyNextButtonCellDelegate: AnyObject {
    func nextButtonClicked()
}


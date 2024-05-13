//
//  MyDiaryRecordViewController.swift
//  MentalHealth
//
//  Created by Yoon on 5/11/24.
//

import UIKit

class MyDiaryRecordViewController: UIViewController {
    
    @IBOutlet weak var quesitonTitleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var niceView: UIView!
    @IBOutlet weak var badView: UIView!
    @IBOutlet weak var niceLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var selected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitalUI()
        niceView.tag = 1
        badView.tag = 2
        tapAction(niceView, selector: #selector(selectMyMood))
        tapAction(badView, selector: #selector(selectMyMood))
    }
    
    func setupInitalUI() {
        niceLabel.font = .customFont(fontType: .bold, size: 12)
        badLabel.font = .customFont(fontType: .bold, size: 12)
        niceLabel.textColor = .soliuBlue
        badLabel.textColor = .red
        niceView.addBorderAndColor(color: .black, width: 1.0)
        badView.addBorderAndColor(color: .black, width: 1.0)
        niceView.layer.cornerRadius = 25
        badView.layer.cornerRadius = 25
        submitButton.isEnabled = false
    }
    
    @objc
    func selectMyMood(_ sender: UITapGestureRecognizer) {
        if let view = sender.view  {
            submitButton.isEnabled = true
            switch view.tag {
                    case 1:
                        niceView.addBorderAndColor(color: .soliuBlue, width: 1.0)
                        badView.addBorderAndColor(color: .black, width: 1.0)
                        niceView.layer.cornerRadius = 25
                        badView.layer.cornerRadius = 25
                    case 2:
                        niceView.addBorderAndColor(color: .black, width: 1.0)
                        badView.addBorderAndColor(color: .red, width: 1.0)
                        niceView.layer.cornerRadius = 25
                        badView.layer.cornerRadius = 25
                    default:
                        print("Unknown view selected")
                    }

        } else {
            print("Tagging Error")
        }
    }
}

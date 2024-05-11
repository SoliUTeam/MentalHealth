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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitalUI()
    }
    
    func setupInitalUI() {
        niceLabel.font = .customFont(fontType: .bold, size: 12)
        badLabel.font = .customFont(fontType: .bold, size: 12)
        niceLabel.textColor = .soliuBlue
        badLabel.textColor = .red
        niceView.addBorderAndColor(color: .soliuBlue, width: 1.0)
        badView.addBorderAndColor(color: .red, width: 1.0)
        niceView.layer.cornerRadius = 25
        badView.layer.cornerRadius = 25
    }
    
}

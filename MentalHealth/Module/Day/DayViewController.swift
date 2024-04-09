//
//  DayViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/4/24.
//

import UIKit

class DayViewController: UIViewController {
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            self.nameLabel.text = "Hi Nickname!"
        }
    }
    
    @IBOutlet weak var feelingOptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCircleShape(welcomeView)
        applyBoader([sundayView, mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView], with: UIColor.tabBarBorder)
        applyStyle(feelingOptionView)
    }
    
    func applyStyle(_ view: UIView) {
        view.layer.cornerRadius = view.layer.frame.height/2
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

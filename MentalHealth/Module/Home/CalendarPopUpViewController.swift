//
//  CalendarPopUpViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/17/24.
//

import Foundation
import UIKit
import FSCalendar


class CalendarPopUpViewController: UIViewController {
    
    private let injectedView: UIView
    
    init(with view: UIView) {
        injectedView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func loadView() {
        view = injectedView
    }
}


extension CalendarPopUpViewController: FSCalendarDataSource, FSCalendarDelegate {}

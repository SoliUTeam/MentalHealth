//
//  CalendarPopUpView.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/17/24.
//

import Foundation
import UIKit
#if os(iOS)
class CalendarPopUpView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
//        .fromNib()
        clipsToBounds = true
        layer.cornerRadius = 5
    }
}
#endif

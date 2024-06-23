//
//  UIButton+Extension.swift
//  MentalHealth
//
//  Created by Yoon on 5/14/24.
//

import Foundation

import UIKit

class AllSubmitButton: UIButton {
    
    // Custom initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.setTitleColor(.white, for: .normal)
        self.setAttributedTitle()
        updateBackgroundColor()
    }

    override var isEnabled: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
        private func updateBackgroundColor() {
            self.backgroundColor = self.isEnabled ? .soliuBlue : .diaryBorder
        }
    
    private func setAttributedTitle() {
        let title = self.titleLabel?.text ?? ""
         let font = UIFont.boldFont16
         let attributes: [NSAttributedString.Key: Any] = [
             .font: font,
             .foregroundColor: UIColor.white
         ]
         let attributedString = NSAttributedString(string: title, attributes: attributes)
         self.setAttributedTitle(attributedString, for: .normal)
     }
}


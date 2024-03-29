//
//  UILabel+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 3/18/24.
//

import Foundation
import UIKit


extension UILabel {
    
    /**
     * @desc anime text like if someone write it
     * @param {String} text,
     * @param {TimeInterval} characterDelay,
     */
    func animate(newTexts: [String], interval: TimeInterval = 0.07, lineSpacing: CGFloat = 1.2, letterSpacing: CGFloat = 1.1) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.2
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.alignment = .center
        var pause: TimeInterval = 0
        var charIndex = 0.0
        self.text = ""
        for newText in newTexts {
            for letter in newText {
                Timer.scheduledTimer(withTimeInterval: interval * charIndex + pause, repeats: false) { (_) in
                    self.text?.append(letter)
                    let attributedString = NSMutableAttributedString(string: self.text ?? "")
                    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
                    attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length - 1))
                    self.attributedText = attributedString
                }
                charIndex += 1
                if(letter == "," || letter == ".") {
                    pause += 0.5
                }
            }
            self.text = ""
        }
    }
}

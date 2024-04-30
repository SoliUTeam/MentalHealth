//
//  UIFont+Extension.swift
//  MentalHealth
//
//  Created by Yoon on 4/28/24.
//

import UIKit

import UIKit

enum RobotoFont: String {
    case black = "Roboto-Black"
    case bold = "Roboto-Bold"
    case medium = "Roboto-Medium"
    case regular = "Roboto-Regular"
}

extension UIFont {
    
    static func customFont(fontType: RobotoFont, size: CGFloat, fallbackFont: UIFont = .systemFont(ofSize: 10)) -> UIFont {
        guard let font = UIFont(name: fontType.rawValue, size: size) else {
            print("Failed to load font: \(fontType.rawValue). Reverting to system font.")
            return fallbackFont
        }
        return font
    }
}

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
    static let regularFont10 = customFont(fontType: .regular, size: 10)
    static let boldFont16 = customFont(fontType: .bold, size: 16)
    //TODO: In some reason black font is not working properly, please check it latter
    static let blackFont16 = customFont(fontType: .black, size: 16)
    static let boldFont12 = customFont(fontType: .bold, size: 12)
    static func customFont(fontType: RobotoFont, size: CGFloat, fallbackFont: UIFont = .systemFont(ofSize: 10)) -> UIFont {
        guard let font = UIFont(name: fontType.rawValue, size: size) else {
            print("Failed to load font: \(fontType.rawValue). Reverting to system font.")
            return fallbackFont
        }
        return font
    }
}

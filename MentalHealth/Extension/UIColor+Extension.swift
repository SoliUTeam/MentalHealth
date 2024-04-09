//
//  UIColor+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 3/21/24.
//

import UIKit

enum Color: String {
    case soliuBlue = "#00B8F1"
    case soliuBlack = "#2E2E2E"
    case viewBorder = "#63DAFF"
    case tabBarBorder = "#CBCBCB"
    case progressBar = "#F5F5F5"
    case progressTrackBar = "#FFE500"
}

extension UIColor {
    static let soliuBlue = UIColor(hex: Color.soliuBlue.rawValue, alpha: 1)
    static let soliuBlack = UIColor(hex: Color.soliuBlack.rawValue, alpha: 1)
    static let viewBorder = UIColor(hex: Color.viewBorder.rawValue, alpha: 1)
    static let tabBarBorder = UIColor(hex: Color.tabBarBorder.rawValue, alpha: 1)
    static let progressBar = UIColor(hex: Color.progressBar.rawValue, alpha: 1)
    static let progressTrackBar = UIColor(hex: Color.progressTrackBar.rawValue, alpha: 1)
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

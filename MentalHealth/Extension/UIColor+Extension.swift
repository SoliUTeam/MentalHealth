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
    case progressBar = "#FFE500"
    case progressTrackBar = "#F5F5F5"
    case progressBarBorder = "#E4E4E4"
    case homepageBackground = "#E5E5E5"
    case submitButtonBackground = "#232323"
    
//  Survey Result Color
    case chartBackground = "#26CCFF"
    case chartAverageBorder = "#1271FF"
    
}

extension UIColor {
    static let soliuBlue = UIColor(hex: Color.soliuBlue.rawValue, alpha: 1)
    static let soliuBlack = UIColor(hex: Color.soliuBlack.rawValue, alpha: 1)
    static let viewBorder = UIColor(hex: Color.viewBorder.rawValue, alpha: 1)
    static let tabBarBorder = UIColor(hex: Color.tabBarBorder.rawValue, alpha: 1)
    static let progressBar = UIColor(hex: Color.progressBar.rawValue, alpha: 1)
    static let progressTrackBar = UIColor(hex: Color.progressTrackBar.rawValue, alpha: 1)
    static let progressBarBorder = UIColor(hex: Color.progressBarBorder.rawValue, alpha: 1)
    static let homepageBackground = UIColor(hex: Color.homepageBackground.rawValue, alpha: 1)
    static let submitButtonBackground = UIColor(hex: Color.submitButtonBackground.rawValue, alpha: 1)
//  Survey Result Color
    static let chartBackground = UIColor(hex: Color.chartBackground.rawValue, alpha: 1)
    static let chartAverageBorder = UIColor(hex: Color.chartAverageBorder.rawValue, alpha: 1)
    
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

//
//  UIView+Extention.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/17/24.
//

import Foundation
import UIKit

enum ViewSide {
    case left, right, top, bottom
}

extension UIView {
    func addBorderAndColor(color: UIColor, width: CGFloat, corner_radius: CGFloat = 0, clipsToBounds: Bool = false) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = corner_radius
        self.clipsToBounds = clipsToBounds
    }
    
    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {
           let border = CALayer()
           border.backgroundColor = color.cgColor
           switch side {
           case .left:
               border.frame = CGRect(x: 0, y: 0, width: thickness, height: bounds.height)
           case .right:
               border.frame = CGRect(x: bounds.width - thickness, y: 0, width: thickness, height: bounds.height)
           case .top:
               border.frame = CGRect(x: 0, y: 0, width: bounds.width, height: thickness)
           case .bottom:
               border.frame = CGRect(x: 0, y: bounds.height - thickness, width: bounds.width, height: thickness)
           }
           
           layer.addSublayer(border)
       }
}

extension UIView {
    @discardableResult
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

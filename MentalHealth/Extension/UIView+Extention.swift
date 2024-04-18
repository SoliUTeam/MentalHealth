//
//  UIView+Extention.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/17/24.
//

import Foundation
import UIKit

extension UIView {

    @discardableResult
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

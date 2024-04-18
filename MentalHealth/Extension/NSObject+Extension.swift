//
//  NSObject+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/17/24.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

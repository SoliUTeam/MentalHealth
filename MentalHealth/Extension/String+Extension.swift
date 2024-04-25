//
//  String+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/9/24.
//

import Foundation

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
}

extension String {
    func capitalizedEachWord() -> String {
        if self == self.capitalized {
            return self
        } else {
            let words = self.components(separatedBy: " ")
            let capitalizedWords = words.map { $0.capitalized }
            return capitalizedWords.joined(separator: " ")
        }
    }
}

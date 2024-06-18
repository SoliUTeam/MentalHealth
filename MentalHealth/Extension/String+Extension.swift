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
    
    static func convertDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yyyy" // Input date format
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "MMMM dd" // Output date format
        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
    }
}

//
//  Date+Extension.swift
//  MentalHealth
//
//  Created by Yoon on 6/6/24.
//

import Foundation

extension Date {
    func toString(dateFormat format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

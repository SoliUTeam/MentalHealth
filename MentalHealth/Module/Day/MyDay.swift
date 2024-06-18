//
//  MyDay.swift
//  MentalHealth
//
//  Created by Yoon on 6/6/24.
//

import Foundation
import UIKit

struct MyDay: Codable {
    var date: String
    var myMood: MyMood
}

enum MyMood: String, Codable {
    case bad
    case sad
    case decent
    case good
    case nice
    
    var moodImage: UIImage? {
        switch self {
        case .bad:
            return UIImage(emotionAssetIdentifier: .badIcon)
        case .sad:
            return UIImage(emotionAssetIdentifier: .sadIcon)
        case .decent:
            return UIImage(emotionAssetIdentifier: .decentIcon)
        case .good:
            return UIImage(emotionAssetIdentifier: .goodIcon)
        case .nice:
            return UIImage(emotionAssetIdentifier: .niceIcon)
        }
    }
}

class WeekViewHelper {
    static func createfilteredMood() -> [MyDay] {
        if !LoginManager.shared.isLoggedIn() {
            print("User Not Logged In")
            return []
        }
        var userMoodList = LoginManager.shared.getDailyMoodList()
        var uniqueMoods: [String: MyMood] = [:]
        for mood in userMoodList {
            uniqueMoods[mood.date] = mood.myMood
        }
        
        userMoodList = uniqueMoods.map { MyDay(date: $0.key, myMood: $0.value) }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let filteredMoods = userMoodList.filter { mood in
            if let moodDate = dateFormatter.date(from: mood.date) {
                return moodDate >= startOfWeek && moodDate <= endOfWeek
            }
            return false
        }
        
        return filteredMoods
        
        
    }
    
    static func getTodayWeekday() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        return weekday
    }
    
    static func getMoodDateFormat() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}

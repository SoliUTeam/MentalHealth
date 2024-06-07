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

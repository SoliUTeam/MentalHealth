//
//  MyDiaryItem.swift
//  MentalHealth
//
//  Created by Yoon on 6/17/24.
//

import Foundation
import UIKit

struct MyDiaryItem: Codable {
    var date: String
    var myDiaryMood: MyDiaryMood
    var answerOne: String
    var answerTwo: String
    var answerThree: String
}


enum MyDiaryMood: String, Codable {
    case bad
    case good
    
    var moodImage: UIImage? {
        switch self {
        case .bad:
            return UIImage(emotionAssetIdentifier: .badBlur)
        case .good:
            return UIImage(emotionAssetIdentifier: .goodBlur)
        }
    }
}

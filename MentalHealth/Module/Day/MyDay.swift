//
//  MyDay.swift
//  MentalHealth
//
//  Created by Yoon on 6/6/24.
//

import Foundation

struct MyDay {
    var date: Date
    var myMood: MyMood
}

enum MyMood: String {
    case bad
    case sad
    case decent
    case good
    case nice
}

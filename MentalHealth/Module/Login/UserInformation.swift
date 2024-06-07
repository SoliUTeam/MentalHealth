//
//  UserInformation.swift
//  MentalHealth
//
//  Created by Yoon on 5/15/24.
//

import Foundation

struct UserInformation {
    var email: String
    var password: String
    var nickName: String
    var gender: String
    var age: String
    var workStatus: String
    var ethnicity: String
    var surveyResult: [SurveyResult]
    var userMoodList: [MyDay]
}

struct SurveyResult: Codable {
    var surveyDate: String
    var surveyAnswer: [Int]
}

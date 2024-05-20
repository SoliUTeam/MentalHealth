//
//  User.swift
//  MentalHealth
//
//  Created by Yoon on 3/27/24.
//

import Foundation

//struct User: Codable {
//    var demographicInformation: DemographicInfo
//    var email: String
//    var surveyResult: [SurveyResult]
//}
//
//struct DemographicInfo: Codable {
//    var email: String
//    var gender: String
//    var statu: String
//}

struct SurveyResult: Codable {
    var surveyDate: String
    var surveyAnswer: [Int]
}



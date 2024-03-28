//
//  User.swift
//  MentalHealth
//
//  Created by Yoon on 3/27/24.
//

import Foundation

struct User: Codable {
    var demographicInformation: DemographicInfo
    var surveyResult: [SurveyResult]
}

struct DemographicInfo: Codable {
    var gender: String
    var firstName: String
    var lastName: String
    
}

struct SurveyResult: Codable {
    var surveyDate: String
    var surveyAnswer: [Int]
}



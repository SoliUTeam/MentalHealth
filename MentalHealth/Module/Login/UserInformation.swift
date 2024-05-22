//
//  UserInformation.swift
//  MentalHealth
//
//  Created by Yoon on 5/15/24.
//

import Foundation

//func createUserData() -> [String] {
//    var userInfo: [String] = []
//    userInfo.append(loginManager.getNickName())
//    userInfo.append(loginManager.getGender())
//    userInfo.append(loginManager.getAge())
//    userInfo.append(loginManager.getWorkStatus())
//    userInfo.append(loginManager.getEthnicity())
//    return userInfo
//}


struct UserInformation {
    var email: String
    var password: String
    var nickName: String
    var gender: String
    var age: String
    var workStatus: String
    var ethnicity: String
    var surveyResult: [SurveyResult]
}

struct SurveyResult: Codable {
    var surveyDate: String
    var surveyAnswer: [Int]
}

//
//  LoginManager.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/15/24.
//

import Foundation

enum Gender: String {
    case male
    case female
    case other
}

enum WorkStatus: String {
    case student
    case employed
    case other
}

enum Ethnicity: String {
    case americanIndian = "American Indian"
    case alaskaNative = "Alaska Native"
    case asian
    case black
    case africanAmerican = "African American"
    case nativeHawaiian = "Native Hawaiian"
    case otherPacificIslander = "Other Pacific Islander"
    case white
    case other
}

///Usage: LoginManager.shared.checkLoggedIn
///
public class LoginManager {
    static let shared = LoginManager()
    
    static let guestUser = UserInformation(email: "guest@gmail.com", password: "guest!", nickName: "Guest", gender: "Male", age: "25", workStatus: "Other", ethnicity: "Asian", surveyResult: [], userMoodList: [])
    
    // Continue as Guest option will be false as default
    private var logInState: Bool = false
    private var nickName: String = "Default"
    private var gender: Gender = .other
    private var age: Int = 0
    private var workStatus: WorkStatus = .other
    private var ethnicity: Ethnicity = .other
    private var email: String = ""
    private var password: String = ""
    private var surveyResult: [SurveyResult] = []
    
//  Initialize starts with guest
    private var currentUser: UserInformation = guestUser
    
    func getUserInfo() -> UserInformation {
        return self.currentUser
    }
    
    func setMyUserInformation(_ userInfo: UserInformation) {
        self.currentUser = userInfo
    }
    
    func getUserMoodList() -> [MyDay] {
        return self.currentUser.userMoodList
    }
    
    func getUserInformation() -> UserInformation {
        return self.currentUser
    }
    
    func setSurveyResult(_ surveyResult: [SurveyResult]) {
        self.surveyResult = surveyResult
    }

    func setLoggedIn(_ loggedIn: Bool) {
        self.logInState = loggedIn
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
    
    func getEmail() -> String {
        let email = logInState ? self.currentUser.email : "Guest@gmail.com"
        return email
    }

    func setPassword(_ password: String) {
        self.password = password
    }

    func isLoggedIn() -> Bool {
        return self.logInState
    }
    
    func setNickName(_ nickName: String) {
        self.nickName = nickName
    }
    
    func getNickName() -> String {
        let nickName = logInState ? self.currentUser.nickName : "Guest"
        return nickName
    }
    
    func setGender(_ gender: Gender) {
        self.gender = gender
    }
    
    func getGender() -> String {
        return gender.rawValue.capitalizedEachWord()
    }
    
    func setAge(_ age: Int) {
        self.age = age
    }
    
    func getAge() -> String {
        return "\(age)"
    }
    
    func setWorkStatus(_ workStatus: WorkStatus) {
        self.workStatus = workStatus
    }
    
    func getWorkStatus() -> String {
        return workStatus.rawValue.capitalizedEachWord()
    }

    func setEthnicity(_ ethnicity: Ethnicity) {
        self.ethnicity = ethnicity
    }
    
    func getEthnicity() -> String {
        return ethnicity.rawValue.capitalizedEachWord()
    }
}

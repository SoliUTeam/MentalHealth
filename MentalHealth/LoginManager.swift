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
    
    static let defualtTestUser = UserInformation(email: "test1234@gmail.com", password: "testingUser1234!", nickName: "testuser1", gender: "Male", age: "25", workStatus: "Other", ethnicity: "Asian")
    
    // Continue as Guest option will be false as default
    private var logInState: Bool = false
    private var nickName: String = "Default"
    private var gender: Gender = .other
    private var age: Int = 0
    private var workStatus: WorkStatus = .other
    private var ethnicity: Ethnicity = .other

    func setLoggedIn(_ loggedIn: Bool) {
        logInState = loggedIn
    }

    func isLoggedIn() -> Bool {
        return logInState
    }
    
    func setNickName(_ nickName: String) {
        self.nickName = nickName
    }
    
    func getNickName() -> String {
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

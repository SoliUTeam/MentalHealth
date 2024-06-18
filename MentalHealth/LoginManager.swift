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
    
    static let guestUser = UserInformation(
        email: "guest@gmail.com",
        password: "guest!",
        nickName: "Guest",
        gender: "Male",
        age: "25",
        workStatus: "Other",
        ethnicity: "Asian",
        surveyResultsList: [],
        dailyMoodList: [],
        diaryEntriesList: []
    )
    
    // Continue as Guest option will be false as default
    private var logInState: Bool = false
    private var currentUser: UserInformation = guestUser

    private init() {}

    // MARK: - User Information

    func getUserInfo() -> UserInformation {
        return self.currentUser
    }

    func setMyUserInformation(_ userInfo: UserInformation) {
        self.currentUser = userInfo
    }

    func getDailyMoodList() -> [MyDay] {
        return self.currentUser.dailyMoodList
    }

    func setSurveyResult(_ surveyResult: [SurveyResult]) {
        self.currentUser.surveyResultsList = surveyResult
    }

    // MARK: - Login State

    func isLoggedIn() -> Bool {
        return self.logInState
    }

    func setLoggedIn(_ loggedIn: Bool) {
        self.logInState = loggedIn
    }

    // MARK: - Guest Flow

    func continueAsGuest() {
        self.currentUser = LoginManager.guestUser
        self.logInState = false
    }

    // MARK: - Login Flow

    func loginSucessFetchInformation(userInformation: UserInformation) {
        // Implement actual login logic here
        // Simulating successful login
        let fetchedUser = userInformation
        self.currentUser = fetchedUser
        self.logInState = true
    }

    // MARK: - Signup Flow

    func signUpUser(userInfo: UserInformation, completion: (Bool) -> Void) {
        // Implement actual signup logic here
        // Simulating successful signup
        self.currentUser = userInfo
        self.logInState = true
        completion(true)
    }

    // MARK: - Helper Methods

    func setEmail(_ email: String) {
        self.currentUser.email = email
    }
    
    func getEmail() -> String {
        return logInState ? self.currentUser.email : "guest@gmail.com"
    }

    func setPassword(_ password: String) {
        self.currentUser.password = password
    }

    func setNickName(_ nickName: String) {
        self.currentUser.nickName = nickName
    }
    
    func getNickName() -> String {
        return currentUser.nickName
    }

    func setGender(_ gender: Gender) {
        self.currentUser.gender = gender.rawValue
    }
    
    func getGender() -> String {
        return currentUser.gender
    }

    func setAge(_ age: Int) {
        self.currentUser.age = "\(age)"
    }
    
    func getAge() -> String {
        return currentUser.age
    }

    func setWorkStatus(_ workStatus: WorkStatus) {
        self.currentUser.workStatus = workStatus.rawValue
    }
    
    func getWorkStatus() -> String {
        return currentUser.workStatus
    }

    func setEthnicity(_ ethnicity: Ethnicity) {
        self.currentUser.ethnicity = ethnicity.rawValue
    }
    
    func getEthnicity() -> String {
        return currentUser.ethnicity
    }
}

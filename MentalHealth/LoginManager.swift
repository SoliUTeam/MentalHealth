//
//  LoginManager.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/15/24.
//

import Foundation

///Usage: LoginManager.shared.checkLoggedIn
///
public class LoginManager {
    static let shared = LoginManager()
    
    // Continue as Guest option will be false as default
    private var logInState: Bool = false
    private var nickName: String = "Default"
    private var gender: Gender = .other

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
        return gender.rawValue
    }
}

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

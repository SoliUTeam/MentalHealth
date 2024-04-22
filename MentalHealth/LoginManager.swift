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
}

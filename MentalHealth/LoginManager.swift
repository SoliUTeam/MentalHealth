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
    
    private var logInState: Bool = false
    
    func setLoggedIn(_ loggedIn: Bool) {
        logInState = loggedIn
    }

    func isLoggedIn() -> Bool {
        return logInState
    }
}

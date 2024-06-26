//
//  Error+Extension.swift
//  MentalHealth
//
//  Created by Yoon on 5/21/24.
//

import Foundation

enum SignInError: Error {
    case emptyEmail
    case emptyPassword
    case userIDCheckFailed(String)
    case userIDDoesNotExist
    case signInFailed(String)
    case fetchingUserInfoError
    case fetchingTestScoreFails
    
    var localizedDescription: String {
        switch self {
        case .emptyEmail:
            return "Email cannot be empty."
        case .emptyPassword:
            return "Password cannot be empty."
        case .userIDCheckFailed(let message):
            return "User ID Check Error: \(message)"
        case .userIDDoesNotExist:
            return "User ID does not exist."
        case .signInFailed(let message):
            return "Sign-In Error: \(message)"
        case .fetchingUserInfoError:
            return "Fail to Fatching Information"
        case .fetchingTestScoreFails:
            return "Fatching Test Scores Fails"
        }
    }
}


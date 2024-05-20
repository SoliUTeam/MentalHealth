//
//  FBNetworkLayer.swift
//  MentalHealth
//
//  Created by Yoon on 3/9/24.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FBNetworkLayer {
    
    static let shared = FBNetworkLayer()
    
    var ref: DatabaseReference!
    var db: Firestore!
    
    private init() {
        ref = Database.database().reference()
        db = Firestore.firestore()
    }
    
    func createAccount(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                completion(error)
            } else {
                print(authResult?.user.uid ?? "No user ID")
                completion(nil)
            }
        }
    }
    
    func fetchUserInformation(userInfo: UserInformation, completion: @escaping (Error?) -> Void) {
        let userData: [String: Any] = [
            "demographicInformation": [
                "email": userInfo.email,
                "gender": userInfo.gender,
                "workStatus":userInfo.workStatus,
                "ethnicity": userInfo.ethnicity,
                "age": userInfo.age,
                "passwrod": userInfo.password,
                "nickname": userInfo.nickName
            ]
        ]
        
        db.collection("Users").addDocument(data: userData) { error in
            if let error = error {
                completion(error)
                print(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchMentalHealthQuestions(completion: @escaping (MentalHealthQuestion?, Error?) -> Void) {
        db.collection("MentalHealthQuestion").getDocuments { (querySnapshot, err) in
            if let err = err {
                completion(nil, err)
                return
            } else {
                guard let document = querySnapshot?.documents.first else {
                    completion(nil, NSError(domain: "FBNetworkLayer", code: 0, userInfo: [NSLocalizedDescriptionKey: "No documents found in MentalHealthQuestion collection"]))
                    return
                }
                do {
                    let question = try document.data(as: MentalHealthQuestion.self)
                    completion(question, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
}

//    func addSurvey(surveyData: SurveyData, completion: @escaping (Error?) -> Void) {
//        var user
//        let db = Firestore.firestore()
//        let userSurveyRef = db.collection("Users").document(userId).collection("Surveys")
//        // Once Login, I need to add user id
//        var surveyDict: [String: Any] = [
//            "answers": surveyData.resultScore
//        ]
//
//        // Add a timestamp if needed
//        surveyDict["timestamp"] = FieldValue.serverTimestamp()
//
//        userSurveyRef.addDocument(data: surveyDict) { error in
//            completion(error)
//        }
//    }

//}

//            let testUser1 = User(
//                demographicInformation: DemographicInfo(gender: "Female", firstName: "Jane", lastName: "Doe"),
//                surveyResult: [
//                    SurveyResult(surveyDate: "2024-03-27", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
//                    SurveyResult(surveyDate: "2024-03-28", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
//                    SurveyResult(surveyDate: "2024-03-29", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
//                ]
//            )
//            fbLayer.fetchUserInformation(userInfo: testUser1) { [weak self] error in
//                guard let self = self else { return }
//                DispatchQueue.main.async {
//                    if let error = error {
//                        print("Error submit getting error: \(error)")
//                        return
//                    }
//                }
//                print("Fetch")
//            }
//
//            fbLayer.fetchMentalHealthQuestions { [weak self] healthQuestion, error in
//                guard let self = self else { return }
//                DispatchQueue.main.async {
//                    if let error = error {
//                        print("Error fetching questions: \(error)")
//                        self.questionsLabel.text = "Error fetching questions"
//                        return
//                    }
//                    self.testInfoArray = healthQuestion?.testQuestions ?? []
//                    self.displayQuestion()
//                }
//            }

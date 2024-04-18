//
//  FBNetworkLayer.swift
//  MentalHealth
//
//  Created by Yoon on 3/9/24.
//

import Foundation
import Firebase
import FirebaseDatabase

class FBNetworkLayer {
    var ref: DatabaseReference!
    var db: Firestore!
    
    let testUser1 = User (
        demographicInformation: DemographicInfo(gender: "Female", firstName: "Jane", lastName: "Doe"),
        surveyResult: [
            SurveyResult(surveyDate: "2024-03-27", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
            SurveyResult(surveyDate: "2024-03-28", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]),
            SurveyResult(surveyDate: "2024-03-29", surveyAnswer: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
        ]
    )
    
    init() {
        ref = Database.database().reference()
        db = Firestore.firestore()
    }
    
    func fetchUserInformation(userInfo: User, completion: @escaping (Error?) -> Void) {
        let userData: [String: Any] = [
            "demographicInformation": [
                "gender": userInfo.demographicInformation.gender,
                "firstName": userInfo.demographicInformation.firstName,
                "lastName": userInfo.demographicInformation.lastName
            ],
            "surveyResults": userInfo.surveyResult.map { surveyResult in
                [
                    "surveyDate": surveyResult.surveyDate,
                    "surveyAnswer": surveyResult.surveyAnswer
                ]
            }
        ]
        
        db.collection("Users").addDocument(data: userData) { error in
            if let error = error {
                completion(error) // Call completion with error if there's an issue
            } else {
                completion(nil) // Call completion with nil when data is successfully added
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
    
}

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

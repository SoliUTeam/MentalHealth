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
    
    func signIn(email: String, password: String, completion: @escaping (Result<UserInformation?, SignInError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Sign-In Error: \(error.localizedDescription)")
                completion(.failure(.signInFailed("Sign In Failed")))
            } else {
                print(authResult?.user.uid ?? "No User ID")
                strongSelf.getUserInformation(email: email) { result in
                    switch result {
                    case .success(let userInfo):
                        completion(.success(nil))
                        LoginManager.shared.loginSucessFetchInformation(userInformation: userInfo)
                        print("Sign Sucessful \(userInfo)")
                    case .failure( _):
                        LoginManager.shared.setLoggedIn(false)
                        completion(.failure(.signInFailed("Fetching Fails")))
                    }
                }
            }
        }
    }
    
    func fetchMyDiary(userInformation: UserInformation, myDiaryItem: MyDiaryItem, completion: @escaping (Error?) -> Void) {
        let email = userInformation.email
        let userRef = db.collection("Users").whereField("demographicInformation.email", isEqualTo: email)
        
        userRef.getDocuments { query, error in
            if let error = error {
                completion(error)
                print("Error getting documents: \(error)")
            } else {
                guard let document = query?.documents.first else {
                    completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                    return
                }
                
                let userDocID = document.documentID
                let userDocRef = self.db.collection("Users").document(userDocID)
                
                let diaryEntryData: [String: Any] = [
                    "date": myDiaryItem.date,
                    "myDiaryMood": myDiaryItem.myDiaryMood.rawValue,
                    "answerOne": myDiaryItem.answerOne,
                    "answerTwo": myDiaryItem.answerTwo,
                    "answerThree": myDiaryItem.answerThree
                ]
                
                userDocRef.updateData([
                    "diaryEntriesList": FieldValue.arrayUnion([diaryEntryData])
                ]) { error in
                    if let error = error {
                        completion(error)
                        print("Error updating document: \(error)")
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func getUserInformation(email: String, completion: @escaping (Result<UserInformation, Error>) -> Void) {
        let userRef = db.collection("Users").whereField("demographicInformation.email", isEqualTo: email)
        
        userRef.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents, let document = documents.first else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }
            
            do {
                let data = document.data()
                let demographicInfo = data["demographicInformation"] as? [String: Any]
                let surveyResultsData = data["surveyResultsList"] as? [[String: Any]] ?? []
                let userMoodResultsData = data["dailyMoodList"] as? [[String: Any]] ?? []
                let userDiaryEntriesData = data["diaryEntriesList"] as? [[String: Any]] ?? []
                
                // Debugging prints
                print("Demographic Info: \(demographicInfo ?? [:])")
                print("Survey Results Data: \(surveyResultsData)")
                print("User Mood Results Data: \(userMoodResultsData)")
                
                let surveyResultsList = try surveyResultsData.map { try JSONDecoder().decode(SurveyResult.self, from: JSONSerialization.data(withJSONObject: $0)) }
                
                let dailyMoodList = try userMoodResultsData.map { try JSONDecoder().decode(MyDay.self, 
                                                                                           from: JSONSerialization.data(withJSONObject: $0))
                }
               
                let diaryEntriesList = try userDiaryEntriesData.map { try JSONDecoder().decode(MyDiaryItem.self, from: JSONSerialization.data(withJSONObject: $0))}
                
                
                let userInfo = UserInformation(
                    email: demographicInfo?["email"] as? String ?? "",
                    password: demographicInfo?["password"] as? String ?? "",
                    nickName: demographicInfo?["nickname"] as? String ?? "",
                    gender: demographicInfo?["gender"] as? String ?? "",
                    age: demographicInfo?["age"] as? String ?? "",
                    workStatus: demographicInfo?["workStatus"] as? String ?? "",
                    ethnicity: demographicInfo?["ethnicity"] as? String ?? "",
                    surveyResultsList: surveyResultsList,
                    dailyMoodList: dailyMoodList,
                    diaryEntriesList: diaryEntriesList
                )
                
                completion(.success(userInfo))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchMyDay(userInfomration: UserInformation, myDay: MyDay, completion: @escaping (Error?) -> Void) {
        let email = userInfomration.email
        let userRef = db.collection("Users").whereField("demographicInformation.email", isEqualTo: email)
        
        userRef.getDocuments { query, error in
            if let error = error {
                completion(error)
                print("Error getting documents: \(error)")
            } else {
                guard let document = query?.documents.first else {
                                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                                return
                }
                
                let userDocID = document.documentID
                let userDocRef = self.db.collection("Users").document(userDocID)
                
                userDocRef.updateData([
                                "dailyMoodList": FieldValue.arrayUnion([[
                                    "date":  myDay.date,
                                    "myMood": myDay.myMood.rawValue
                                ]])
                            ]) { error in
                                if let error = error {
                                    completion(error)
                                    print("Error updating document: \(error)")
                                } else {
                                    completion(nil)
                                }
                }
            }
        }
    }
    
    
    func getAllSurveyResult(completion: @escaping (Result<[SurveyResult], Error>) -> Void) {
        let allTestRef = db.collection("All_Test_Results")
        
        allTestRef.getDocuments { query, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = query?.documents else {
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No survey results found"])))
                        return
            }
            var surveyResults: [SurveyResult] = []
            
            for document in documents {
                let data = document.data()
                            if let surveyDate = data["surveyDate"] as? String,
                               let surveyAnswer = data["surveyAnswer"] as? [Int] {
                                    let surveyResult = SurveyResult(surveyDate: surveyDate, surveyAnswer: surveyAnswer)
                                        surveyResults.append(surveyResult)
                    }
            }
            completion(.success(surveyResults))
        }
    }
    
    
    
    
    func addSurvey(userInfomration: UserInformation, newSurveyResult: SurveyResult, completion: @escaping (Error?)-> Void) {
        let email = userInfomration.email
        let userRef = db.collection("Users").whereField("demographicInformation.email", isEqualTo: email)
        let allTestRef = db.collection("All_Test_Results")
        
        userRef.getDocuments { querySnapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let documents = querySnapshot?.documents,
                  let document = documents.first else {
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User Not founc"]))
                return
            }
            
            
            var userData = document.data()
            var surveyResults = userData["surveyResultsList"] as? [[String: Any]] ?? []
            
            let newSurveyResultData: [String: Any] = [
                "surveyDate": newSurveyResult.surveyDate,
                "surveyAnswer": newSurveyResult.surveyAnswer
            ]
            
            surveyResults.append(newSurveyResultData)
            userData["surveyResultsList"] = surveyResults
            
            let batch = self.db.batch()
            
            document.reference.updateData(userData) { error in
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
            
            let userDocumentRef = document.reference
            batch.updateData(userData, forDocument: userDocumentRef)
            
            // Add new survey result to All_Test_Results collection
            let allTestResultData: [String: Any] = [
                "surveyDate": newSurveyResult.surveyDate,
                "surveyAnswer": newSurveyResult.surveyAnswer
            ]
            
            let newTestResultRef = allTestRef.document()
            batch.setData(allTestResultData, forDocument: newTestResultRef)
            
            // Commit the batch
            batch.commit { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
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
    
    func checkEmailExists(email: String, completion: @escaping (Bool, Error?) -> Void) {
        db.collection("EmailList").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error)
            } else {
                if let documents = querySnapshot?.documents, documents.count > 0 {
                    completion(true, nil)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
    
    func addEmailToList(email: String, completion: @escaping (Error?) -> Void) {
        let emailData: [String: Any] = ["email": email]
        db.collection("EmailList").addDocument(data: emailData) { error in
            completion(error)
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
            ],
            "surveyResultsList": [],
            "dailyMoodList" : [],
            "diaryEntriesList" : [],
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
}

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

    init() {
        ref = Database.database().reference()
    }
    
    func fetchMentalHealthQuestions(completion: @escaping (MentalHealthQuestion?, Error?) -> Void) {
        let db = Firestore.firestore()
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

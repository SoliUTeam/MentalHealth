//
//  TestingInformation.swift
//  MentalHealth
//
//  Created by Yoon on 3/31/24.
//

import Foundation

class TestingInformation {
    var testInfoArray: [TestQuestion] = [
        TestQuestion(id: 0, questionNumber: 0, type: "Depression", question: "I felt downhearted and blue."),
        TestQuestion(id: 0, questionNumber: 1, type: "Depression", question: "I felt that I had nothing to look forward to."),
        TestQuestion(id: 0, questionNumber: 2, type: "Depression", question: "I felt that life was meaningless."),
        TestQuestion(id: 0, questionNumber: 3, type: "Depression", question: "I felt I wasn’t worth much as a person."),
        TestQuestion(id: 0, questionNumber: 4, type: "Depression", question: "I was unable to become enthusiastic about anything."),
        TestQuestion(id: 1, questionNumber: 5, type: "Anxiety", question: "I was aware of dryness of my mouth."),
        TestQuestion(id: 1, questionNumber: 6, type: "Anxiety", question: "I experienced trembling (e.g., in the hands)."),
        TestQuestion(id: 1, questionNumber: 7, type: "Anxiety", question: "I was worried about situations in which I might panic and make a fool of myself."),
        TestQuestion(id: 1, questionNumber: 8, type: "Anxiety", question: "I felt I was close to panic."),
        TestQuestion(id: 1, questionNumber: 9, type: "Anxiety", question: "I felt scared without any good reason."),
        TestQuestion(id: 2, questionNumber: 10, type: "Stress", question: "I found it hard to wind down."),
        TestQuestion(id: 2, questionNumber: 11, type: "Stress", question: "I felt that I was using a lot of nervous energy."),
        TestQuestion(id: 2, questionNumber: 12, type: "Stress", question: "I found myself getting agitated."),
        TestQuestion(id: 2, questionNumber: 13, type: "Stress", question: "I tended to over-react to situations."),
        TestQuestion(id: 2, questionNumber: 14, type: "Stress", question: "I was intolerant of anything that kept me from getting on with what I was doing."),
        TestQuestion(id: 3, questionNumber: 15, type: "Loneliness", question: "I lack companionship."),
        TestQuestion(id: 3, questionNumber: 16, type: "Loneliness", question: "I feel isolated from others."),
        TestQuestion(id: 3, questionNumber: 17, type: "Loneliness", question: "I am no longer close to anyone."),
        TestQuestion(id: 3, questionNumber: 18, type: "Loneliness", question: "My interests and ideas are not shared by those around me."),
        TestQuestion(id: 3, questionNumber: 19, type: "Loneliness", question: "My social relationships are superficial."),
        TestQuestion(id: 4, questionNumber: 20, type: "Social Media Addiction", question: "You spend a lot of time thinking about social media or planning how to use it."),
        TestQuestion(id: 4, questionNumber: 21, type: "Social Media Addiction", question: "You feel an urge to use social media more and more."),
        TestQuestion(id: 4, questionNumber: 22, type: "Social Media Addiction", question: "You use social media in order to forget about personal problems."),
        TestQuestion(id: 4, questionNumber: 23, type: "Social Media Addiction", question: "You become restless or troubled if you are prohibited from using social media."),
        TestQuestion(id: 4, questionNumber: 24, type: "Social Media Addiction", question: "You use social media so much that it has had a negative impact on your job/studies.")

    ]
    
    func createTestingSurveyQuestion() -> [TestQuestion] {
        return testInfoArray
    }

}

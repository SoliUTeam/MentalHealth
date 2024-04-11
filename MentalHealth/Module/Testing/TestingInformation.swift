//
//  TestingInformation.swift
//  MentalHealth
//
//  Created by Yoon on 3/31/24.
//

import Foundation

class TestingInformation {
    var testInfoArray: [TestQuestion] = [
        TestQuestion(questionId: 0, id: 0, type: "Depression", question: "I felt downhearted and blue."),
        TestQuestion(questionId: 1, id: 0, type: "Depression", question: "I felt that I had nothing to look forward to."),
        TestQuestion(questionId: 2, id: 0, type: "Depression", question: "I felt that life was meaningless."),
        TestQuestion(questionId: 3, id: 0, type: "Depression", question: "I felt I wasn’t worth much as a person."),
        TestQuestion(questionId: 4, id: 0, type: "Depression", question: "I was unable to become enthusiastic about anything."),
        TestQuestion(questionId: 5, id: 1, type: "Anxiety", question: "I was aware of dryness of my mouth."),
        TestQuestion(questionId: 6, id: 1, type: "Anxiety", question: "I experienced trembling (e.g., in the hands)."),
        TestQuestion(questionId: 7, id: 1, type: "Anxiety", question: "I was worried about situations in which I might panic and make a fool of myself."),
        TestQuestion(questionId: 8, id: 1, type: "Anxiety", question: "I felt I was close to panic."),
        TestQuestion(questionId: 9, id: 1, type: "Anxiety", question: "I felt scared without any good reason."),
        TestQuestion(questionId: 10, id: 2, type: "Stress", question: "I found it hard to wind down."),
        TestQuestion(questionId: 11, id: 2, type: "Stress", question: "I felt that I was using a lot of nervous energy."),
        TestQuestion(questionId: 12, id: 2, type: "Stress", question: "I found myself getting agitated."),
        TestQuestion(questionId: 13, id: 2, type: "Stress", question: "I tended to over-react to situations."),
        TestQuestion(questionId: 14, id: 2, type: "Stress", question: "I was intolerant of anything that kept me from getting on with what I was doing."),
        TestQuestion(questionId: 15, id: 3, type: "Loneliness", question: "I lack companionship."),
        TestQuestion(questionId: 16, id: 3, type: "Loneliness", question: "I feel isolated from others."),
        TestQuestion(questionId: 17, id: 3, type: "Loneliness", question: "I am no longer close to anyone."),
        TestQuestion(questionId: 18, id: 3, type: "Loneliness", question: "My interests and ideas are not shared by those around me."),
        TestQuestion(questionId: 19, id: 3, type: "Loneliness", question: "My social relationships are superficial."),
        TestQuestion(questionId: 20, id: 4, type: "Social Media Addiction", question: "You spend a lot of time thinking about social media or planning how to use it."),
        TestQuestion(questionId: 21, id: 4, type: "Social Media Addiction", question: "You feel an urge to use social media more and more."),
        TestQuestion(questionId: 22, id: 4, type: "Social Media Addiction", question: "You use social media in order to forget about personal problems."),
        TestQuestion(questionId: 23, id: 4, type: "Social Media Addiction", question: "You become restless or troubled if you are prohibited from using social media."),
        TestQuestion(questionId: 24, id: 4, type: "Social Media Addiction", question: "You use social media so much that it has had a negative impact on your job/studies.")

    ]
    
    func createTestingSurveyQuestion() -> [TestQuestion] {
        return testInfoArray
    }

}

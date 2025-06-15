//
//  Question.swift
//  Mutual
//
//  Created by Alan Alexander on 6/14/25.
//

import Foundation



// We still need the question type
enum QuestionType: Codable { // Codable allows us to potentially load from JSON later
    case multipleChoice
    case freeResponse
}

// A single answer option, which now points to the next question.
struct AnswerOption: Identifiable, Codable {
    let id = UUID()
    let text: String
    let nextQuestionID: String? // Points to the ID of the next question. `nil` means end of path.
    let prevQuestionID: String?
}

// The new Question model.
struct Question: Identifiable, Codable {
    let id: String // Using a human-readable String for the ID is now crucial.
    let type: QuestionType
    let text: String
    let options: [AnswerOption]? // Options are now of type AnswerOption.
    
    // For free-response, where to go after the user hits 'Continue'.
    let nextQuestionID: String?
    let prevQuestionID: String?
}



//
//  QuestionService.swift
//  Mutual
//
//  Created by Alan Alexander on 6/14/25.
//


import Foundation

class QuizService {
    
    // This is our "database" of all possible questions.
    // Using a dictionary with the question's ID as the key makes lookups instant.
    private let allQuestions: [String: Question]

    init() {
        self.allQuestions = QuizService.loadAllQuestions()
    }
    
    /// Returns the very first question of the quiz.
    func getInitialQuestion() -> Question? {
        return allQuestions["start"]
    }
    
    /// Returns a specific question by its ID.
    func getQuestion(byID id: String) -> Question? {
        return allQuestions[id]
    }
    
    // This is where you define your entire branching quiz flow.
    private static func loadAllQuestions() -> [String: Question] {
        let questions: [Question] = [
            
            // --- Entry Point ---
            Question(id: "start",
                     type: .multipleChoice,
                     text: "To get to know you better, which of these best describes you?",
                     options: [
                        AnswerOption(text: "College Student", nextQuestionID: "q_student_major", prevQuestionID: nil),
                        AnswerOption(text: "Employed", nextQuestionID: "q_employed_industry", prevQuestionID: nil),
                        AnswerOption(text: "Founder / Entrepreneur", nextQuestionID: "q_founder_stage", prevQuestionID: nil),
                        AnswerOption(text: "Investor", nextQuestionID: "q_investor_focus", prevQuestionID: nil)
                     ],
                     nextQuestionID: nil, prevQuestionID: nil), // Not needed for multiple choice
            
            // --- BRANCH 1: College Student ---
            Question(id: "q_student_major",
                     type: .freeResponse,
                     text: "Awesome! What are you studying?",
                     options: nil,
                     nextQuestionID: "q_student_graduation",
                     prevQuestionID: "start"),
            
            Question(id: "q_student_graduation",
                     type: .freeResponse,
                     text: "And when do you expect to graduate?",
                     options: nil,
                     nextQuestionID: "q_common_goal",
                    prevQuestionID: "q_student_major"), // Merges back into a common path
            
            // --- BRANCH 2: Employed ---
            Question(id: "q_employed_industry",
                     type: .freeResponse,
                     text: "Great! What industry do you work in?",
                     options: nil,
                     nextQuestionID: "q_employed_role",
                     prevQuestionID: "start"),
                     
            Question(id: "q_employed_role",
                     type: .freeResponse,
                     text: "And what is your current role?",
                     options: nil,
                     nextQuestionID: "q_common_goal",
                     prevQuestionID: "q_employed_industry"), // Merges back
            
            // --- BRANCH 3: Founder / Entrepreneur ---
            Question(id: "q_founder_stage",
                     type: .multipleChoice,
                     text: "Exciting! What stage is your venture at?",
                     options: [
                        AnswerOption(text: "Idea / Pre-seed", nextQuestionID: "q_common_goal", prevQuestionID: "start"),
                        AnswerOption(text: "Seed / Series A", nextQuestionID: "q_common_goal", prevQuestionID: "start"),
                        AnswerOption(text: "Growth / Scaling", nextQuestionID: "q_common_goal", prevQuestionID: "start")
                     ],
                     nextQuestionID: nil, prevQuestionID: nil),
            
            // --- BRANCH 4: Investor ---
            Question(id: "q_investor_focus",
                     type: .multipleChoice,
                     text: "Perfect. What is your primary investment focus?",
                     options: [
                        AnswerOption(text: "Early-stage (Pre-seed/Seed)", nextQuestionID: "q_common_goal", prevQuestionID: "start"),
                        AnswerOption(text: "Venture (Series A+)", nextQuestionID: "q_common_goal", prevQuestionID: "start"),
                        AnswerOption(text: "Angel / Personal", nextQuestionID: "q_common_goal", prevQuestionID: "start")
                     ],
                     nextQuestionID: nil, prevQuestionID: nil),
            
            // --- Common Path / End Point ---
            Question(id: "q_common_goal",
                     type: .multipleChoice,
                     text: "Finally, what are you hoping to find on Mutual?",
                     options: [
                        AnswerOption(text: "Friendship", nextQuestionID: nil, prevQuestionID: "start"), // `nil` ends the quiz
                        AnswerOption(text: "Networking", nextQuestionID: nil, prevQuestionID: "start"),
                        AnswerOption(text: "A Co-founder", nextQuestionID: nil, prevQuestionID: "start")
                     ],
                     nextQuestionID: nil, prevQuestionID: nil)
        ]
        
        // Convert the array into a dictionary for fast O(1) lookups.
        return Dictionary(uniqueKeysWithValues: questions.map { ($0.id, $0) })
    }
}

//
//  QuizController.swift
//  Mutual
//
//  Created by Alan Alexander on 6/14/25.
//

import Foundation
import Combine

class QuizController: ObservableObject {
    
    // MARK: - Published Properties
    // These properties will notify the view when they change.
    @Published var currentQuestion: Question?
    @Published var userAnswers: [String: String] = [:]
    @Published var quizCompleted: Bool = false
    @Published var questionHistory: [String] = []

    // MARK: - Private Properties
    private let quizService = QuizService()
    
    // MARK: - Computed Properties
    var quizProgress: Float {
        let totalEstimatedQuestions = 5.0
        // We subtract 1 from the count because we don't want the progress bar
        // to be full until the last question is *answered*, not just shown.
        let completedQuestions = max(0, questionHistory.count - 1)
        return min(1.0, Float(completedQuestions) / Float(totalEstimatedQuestions))
    }
    
    // MARK: - Initializer
    init() {
        if let initialQuestion = quizService.getInitialQuestion() {
            self.currentQuestion = initialQuestion
            // CRITICAL: Add the first question to the history.
            self.questionHistory.append(initialQuestion.id)
        }
    }
    
    // MARK: - Public Methods
    
    // This function must be a method of the class, NOT inside init().
    func selectAnswer(for questionID: String, answerText: String, nextQuestionID: String?) {
        userAnswers[questionID] = answerText
        
        if let nextID = nextQuestionID, let nextQuestion = quizService.getQuestion(byID: nextID) {
            currentQuestion = nextQuestion
            questionHistory.append(nextID)
        } else {
            quizCompleted = true
            print("Quiz completed! Answers: \(userAnswers)")
        }
    }
    
    // This function must also be a method of the class.
    func goToPreviousQuestion() {
        guard questionHistory.count > 1 else {
            print("Already at the beginning.")
            return
        }
        
        _ = questionHistory.popLast()
        
        if let previousQuestionID = questionHistory.last,
           let previousQuestion = quizService.getQuestion(byID: previousQuestionID) {
            
            currentQuestion = previousQuestion
            userAnswers.removeValue(forKey: previousQuestionID)
        }
    }
}








//import Foundation
//import Combine
//
//
//
//class QuizController: ObservableObject {
//    
//    var quizProgress: Float {
//        // A more reliable progress calculation based on the history.
//        // Let's assume an average quiz length of 5 for the total.
//        let totalEstimatedQuestions = 5.0
//        
//        // Ensure we don't divide by zero or go over 1.0
//        return min(1.0, Float(questionHistory.count) / Float(totalEstimatedQuestions))
//    }
//    
//    private let quizService = QuizService()
//    
//    // @Published properties
//    @Published var currentQuestion: Question?
//    @Published var userAnswers: [String: String] = [:] // Key: Question ID, Value: Answer Text
//    @Published var quizCompleted: Bool = false
//    
//    @Published var questionHistory: [String] = []
//    
//    // Computed property for progress
//    
//    
//    init() {
//        if let initialQuestion = quizService.getInitialQuestion() {
//            self.currentQuestion = initialQuestion
//            
//            self.currentQuestion = quizService.getInitialQuestion()
//        }
//        
//        func selectAnswer(for questionID: String, answerText: String, nextQuestionID: String?) {
//            userAnswers[questionID] = answerText
//            
//            // Now, navigate based on the provided nextQuestionID
//            if let nextID = nextQuestionID, let nextQuestion = quizService.getQuestion(byID: nextID) {
//                currentQuestion = nextQuestion
//                questionHistory.append(nextID)
//                
//                
//            } else {
//                // If there's no next question, the quiz is over.
//                
//                quizCompleted = true
//                print("Quiz completed! Answers: \(userAnswers)")
//            }
//        }
//        
//        
//        // --- NEW METHOD FOR GOING BACK ---
//        func goToPreviousQuestion() {
//            
//            guard questionHistory.count > 1 else {
//                        print("Already at the beginning.")
//                        return
//                    }
//            // 1. Remove the current question from history.
//            _ = questionHistory.popLast()
//            
//            // 2. Get the new "last" question ID from our history.
//            if let previousQuestionID = questionHistory.last,
//               let previousQuestion = quizService.getQuestion(byID: previousQuestionID) {
//                
//                // 3. Set it as the current question.
//                currentQuestion = previousQuestion
//                
//                // 4. (Optional but good practice) Remove the answer for the question we are leaving.
//                if let currentQ = currentQuestion {
//                    userAnswers.removeValue(forKey: currentQ.id)
//                }
//                
//            } else {
//                // This case should ideally not be hit if the back button is disabled on the first screen.
//                print("Already at the beginning.")
//            }
//            
//          
//        }
//    }
//}

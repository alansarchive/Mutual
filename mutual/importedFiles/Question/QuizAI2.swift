//
//  QuizAI2.swift
//  Mutual
//
//  Created by Alan Alexander on 6/14/25.
//



import SwiftUI

struct QuizAI2: View {
    // These @State properties are not needed here anymore, as the controller manages all state.
    // @State private var freeResponseText: String = "" --> Replaced with a local variable
    // @State private var selectedOption: String? --> Replaced by checking the controller
    
    // The controller is the single source of truth for all quiz state.
    @StateObject private var quizController = QuizController()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea(edges: .all)
                
                VStack(spacing: 10) {
                    
                    HStack {
                        // --- FIX #3: Back Button Logic ---
                        Button {
                            quizController.goToPreviousQuestion()
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.Beige) // Changed to white for better visibility
                                .clipShape(Circle())
                        }
                        .disabled(quizController.questionHistory.count <= 1)
                        .opacity(quizController.questionHistory.count <= 1 ? 0 : 1)
                        .animation(.easeInOut, value: quizController.questionHistory.count)
                        
                        
                        // --- FIX #1: Progress Bar Logic ---
                        // Use the 'quizProgress' computed property from your controller.
                        ProgressView(value: quizController.quizProgress)
                            .tint(.white)
                            .padding(.horizontal)
                        
                    }
                    .padding(.horizontal)
                    
                    if let currentQuestion = quizController.currentQuestion {
                        // Pass the controller down so child views can read/write state
                        questionContent(question: currentQuestion, controller: quizController)
                    } else {
                        Text("Loading Quiz...")
                            .foregroundColor(.white)
                    }
                }
                
                // This is a great way to handle the final navigation!
                // It listens for the 'quizCompleted' property to become true.
                NavigationLink(destination: SignUpView().ignoresSafeArea().toolbar(.hidden, for:.navigationBar), isActive: $quizController.quizCompleted) {
                    EmptyView()
                }
            }
        }
    }
}

// --- Make questionContent a separate struct for better state management ---
private struct questionContent: View {
    let question: Question
    @ObservedObject var controller: QuizController
    
    // Use a local @State for the text field, specific to this view
    @State private var freeResponseText: String = ""

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(question.text)
                .foregroundColor(.white)
                .font(.system(size: 35, weight: .bold))
                .padding()
            
            Text("The developers at Mutual do not give a shit about your privacy lol")
                .foregroundColor(.white)
                .padding(.horizontal)
                .font(.system(size: 18))
                .padding(.bottom, 80)
            
            switch question.type {
            case .multipleChoice:
                multipleChoiceButtons(for: question.options!, questionID: question.id)
            case .freeResponse:
                freeResponseTextField
            }
            
            Spacer()
            
            if question.type == .freeResponse {
                Button(action: {
                    controller.selectAnswer(
                        for: question.id,
                        answerText: freeResponseText,
                        nextQuestionID: question.nextQuestionID
                    )
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.Beige) // Use Color.white or your custom Beige
                        .cornerRadius(10)
                        .padding([.top, .leading, .trailing])
                        .padding(.bottom, 50)
                }
                .disabled(freeResponseText.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .padding(.horizontal)
        // Reset the local text field when the question ID changes
        .onChange(of: question.id) { _ in
            freeResponseText = ""
        }
    }

    private func multipleChoiceButtons(for options: [AnswerOption], questionID: String) -> some View {
        VStack(spacing: 12) {
            ForEach(options) { option in
                // --- FIX #2: Selection Logic ---
                // The 'isSelected' check must read from the controller's answer dictionary.
                let isSelected = (controller.userAnswers[questionID] == option.text)
                
                Button(action: {
                    controller.selectAnswer(
                        for: questionID,
                        answerText: option.text,
                        nextQuestionID: option.nextQuestionID
                    )
                }) {
                    Text(option.text)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(isSelected ? .black : .white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isSelected ? Color.white : Color.clear)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.7), lineWidth: 1.5)
                        )
                }
            }
        }
    }
    
    private var freeResponseTextField: some View {
        TextField("Type your answer here...", text: $freeResponseText)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .foregroundColor(.white)
            .font(.headline)
    }
}


#Preview{
    QuizAI2()
}

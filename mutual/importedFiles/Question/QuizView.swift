//
//  QuizView.swift
//  Mutual
//
//  Created by Alan Alexander on 6/14/25.
//

import SwiftUI





struct QuizView: View {

    let options = ["Joe", "James", "Bob", "Cleveland Brown"]
    
    @State private var selectedOption: String?
    
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                Color.black
                    .ignoresSafeArea(edges: .all)
                VStack( spacing: 10) {
                    HStack{
                        NavigationLink{
                            Welcome()
                                .toolbar(.hidden, for:.navigationBar)
                                                            .ignoresSafeArea()
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.Beige)
                                .clipShape(Circle())
                            
                        }
                        
                        
                        ProgressView(value: Double(5), total: Double(10))
                            .tint(.white) // 3. Makes the progress bar's fill color white.
                            .padding(.horizontal) // Adds some space around the bar.
                        
                    }
                    .padding(.horizontal)
                    
                    
                    Text("What's your name?")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold))
                        .padding()
                    
                    Text("This will be given to the Chinese government to spy on you.")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .font(.system(size: 18))
                        .padding(.bottom, 80)
                    
                    VStack(spacing: 12) {
                        ForEach(options, id: \.self) { option in
                            // The isSelected variable makes the code cleaner
                            let isSelected = (selectedOption == option)
                            
                            Button(action: {
                                // When a button is tapped, update the selected option.
                                selectedOption = option
                            }) {
                                Text(option)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(isSelected ? .black : .white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    // The background changes based on selection
                                    .background(isSelected ? Color.white : Color.clear)
                                    .cornerRadius(12)
                                    // The border is always visible for unselected items
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.white.opacity(0.7), lineWidth: 1.5)
                                    )
                            }
                        }
                    }
                    
                    Spacer()
                    
                    
                    NavigationLink{
                       QuizView()
                            .toolbar(.hidden, for:.navigationBar)
                                                        .ignoresSafeArea()
                    } label: {
                        Text("Continue")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.Beige)
                            .cornerRadius(10)
                            .padding([.top, .leading, .trailing])
                    }
                    .padding(.bottom, 50)
                    
                    
                    
                    
                    
                    }
                    
                    
                    
                    Spacer()
                }
                                      
                
                }
                .navigationBarBackButtonHidden(true)
            
            }
          
        }
      
      
    
  


#Preview {
    QuizView()
}

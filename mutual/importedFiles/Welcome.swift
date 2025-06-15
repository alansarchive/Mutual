//
//  Welcome.swift
//  Mutual
//
//  Created by Alan Alexander on 6/14/25.
//

import SwiftUI
import UIKit

struct Welcome: View {
    
@State private var showQuizView = false
    var body: some View {
            
        if showQuizView {
                        // If true, show the QuizView
                        QuizAI2() // Pass a binding to allow going back
                            .transition(.opacity) // 3. The fade transition!
            
                       
        }
        else {
            NavigationStack{
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack(spacing: 20){
                        VStack(spacing: 0){
                            Text("Make")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                            
                            ZStack{
                                Text("Connections")
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.white)
                                    .overlay(
                                        Image("Squiggle")
                                            .resizable()
                                            .frame(width: 300)
                                    )
                                
                                
                                
                                
                                
                                // help make this better and look more great on different devices
                                //also how come the text spacing is off
                                
                                
                                
                            }
                            
                            Text("Friendships")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                            
                            
                            
                            
                            
                        }
                        .frame(width: .infinity)
                        .padding(10)
                        
                        Button {
                            // 5. This is the magic. When tapped, it will set
                            //    showQuizView to true, triggering the transition.
                            showQuizView = true
                        } label: {
                            Text("Get Started")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.Beige)
                                .cornerRadius(10)
                                .padding([.top, .leading, .trailing])
                        }
                                                
                        
//                        NavigationLink{
//                            QuizView()
//                            
//                        } label: {
//                            Text("Get Started")
//                                .font(.system(size: 18, weight: .semibold))
//                                .foregroundColor(.black)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.Beige)
//                                .cornerRadius(10)
//                                .padding([.top, .leading, .trailing])
//                            
//                            
//                        }
                        
                        
                        
                        
                        
                        
                        HStack{
                            Text("Already have an account?")
                                .foregroundColor(.white)
                            
                            NavigationLink{
                                LoginView()
                                    .toolbar(.hidden, for:.navigationBar)
                                    .ignoresSafeArea()
                            } label: {
                                Text("Sign in")
                                    .fontWeight(.bold)
                                    .foregroundColor(.Beige)
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    .navigationBarBackButtonHidden(true)
                    
                    
                    
                }
            }
        }
        
      
        
            }
}

#Preview {
    Welcome()
}

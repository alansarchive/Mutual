//
//  AuthenticationViews.swift
//  Mutual
//
//  Created by Alan Alexander on 6/14/25.
//

import SwiftUI

// MARK: - Shared View Modifiers & Styles
// In a real project, this section would live in its own file (e.g., "ViewModifiers.swift").

/// A ViewModifier to apply a consistent style to all text input fields.
struct CustomTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .foregroundColor(.white)
            .font(.headline)
    }
}

/// A ViewModifier for the main "call to action" button style.
struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
    }
}

/// Extension on View to make applying the custom styles cleaner and more readable.
extension View {
    func styleAsCustomTextField() -> some View {
        self.modifier(CustomTextFieldModifier())
    }
    
    func styleAsPrimaryButton() -> some View {
        self.modifier(PrimaryButtonModifier())
    }
}


// MARK: - Login View
// The view for existing users to sign in.

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var login = false;

    var body: some View {
        
        if login{
            SignUpView()
                    .toolbar(.hidden, for:.navigationBar)
                    .ignoresSafeArea()
        }
        else{
            
        }
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    
                    // --- Header ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome Back")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Sign in to continue to Mutual.")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.white)
                    
                    // --- Form Fields ---
                    VStack(spacing: 25) {
                        Text("Email")
                        TextField("Enter your email", text: $email)
                            .styleAsCustomTextField()
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Enter your password", text: $password)
                            .styleAsCustomTextField()
                    }
                    .padding(.top, 10)
                    
                    // --- Sign In Button ---
                    NavigationLink{
                        uiconvert()
                            .toolbar(.hidden, for:.navigationBar)
                            .ignoresSafeArea()
                        
//                            .navigationBarBackButtonHidden(true)
                        
                    } label: {
                        Text("Sign In")
                    }
                    .styleAsPrimaryButton()
                    .padding(.top, 20)
                    
                    
                    Spacer()
                    Spacer()
                    
                    // --- Footer link to Sign Up ---
                    HStack {
                        Spacer()
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        Button(action: {login = true})
//                            SignUpView()
//                                .toolbar(.hidden, for:.navigationBar)
//                                .ignoresSafeArea()
                        /*} label: */{
                            Text("Sign up")
                                .fontWeight(.bold)
                                .foregroundColor(.Beige)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


// MARK: - Sign Up View
// The view for new users to create an account.

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    // Computed property to handle button validation logic cleanly.
    private var isSignUpButtonDisabled: Bool {
        return fullName.isEmpty || email.isEmpty || password.isEmpty || password != confirmPassword
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    
                    // --- Header ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Create Account")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Join the Mutual community to connect with others.")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.white)
                    
                    // --- Form Fields ---
                    VStack(spacing: 25) {
                        TextField("Enter your full name", text: $fullName)
                            .styleAsCustomTextField()
                            .autocapitalization(.words)
                        
                        TextField("Enter your email", text: $email)
                            .styleAsCustomTextField()
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Create a password", text: $password)
                            .styleAsCustomTextField()
                        
                        SecureField("Confirm your password", text: $confirmPassword)
                            .styleAsCustomTextField()
                    }
                    .padding(.top, 10)
                    
                    // --- Validation Error Message ---
                    if !password.isEmpty && !confirmPassword.isEmpty && password != confirmPassword {
                        Text("Passwords do not match.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, -10) // Negative padding to bring it closer
                    }
                    
                    // --- Create Account Button ---
                    NavigationLink{
                        uiconvert()
                            .toolbar(.hidden, for:.navigationBar)
                            .ignoresSafeArea()
//                            .navigationBarBackButtonHidden(true)
                    }label: {
                        Text("Create Account")
                    }
                    .styleAsPrimaryButton()
                    .disabled(isSignUpButtonDisabled)
                    .opacity(isSignUpButtonDisabled ? 0.6 : 1.0)
                    .animation(.easeIn(duration: 0.2), value: isSignUpButtonDisabled)
                    .padding(.top, 20)
                    
                    Spacer()
                    Spacer()
                    
                    // --- Footer link to Sign In ---
                    HStack {
                        Spacer()
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        NavigationLink{
                            LoginView()
                                .toolbar(.hidden, for:.navigationBar)
                                .ignoresSafeArea()
                        } label: {
                            Text("Sign in")
                                .fontWeight(.bold)
                                .foregroundColor(.Beige)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
        
    }
}


// MARK: - Preview Provider
// This combines both views into a TabView for easy previewing in Xcode.

struct AuthenticationViews_Previews: PreviewProvider {
    static var previews: some View {
        // Use a TabView to easily switch between Login and Sign Up in the preview canvas.
        TabView {
            LoginView()
                .tabItem {
                    Label("Sign In", systemImage: "person.fill")
                }
            
            SignUpView()
                .tabItem {
                    Label("Sign Up", systemImage: "person.crop.circle.badge.plus")
                }
        }
    }
}

//
//  SignInView.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 2/1/25.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isSignInSuccessful = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                // Email Field
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "envelope")
                            .font(.system(size: 40))
                            .foregroundColor(.black)
                        TextField("Email", text: $email)
                            .font(.system(size: 20))
                    }
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(.black)
                }
                
                // Password Field
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "lock")
                            .font(.system(size: 40))
                            .foregroundColor(.black)
                        SecureField("Password", text: $password)
                            .font(.system(size: 20))
                    }
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(.black)
                }
                
                // Sign In Button


                Button(action: {
                    Task {
                        await viewModel.signIn(email: email, password: password)
                                if viewModel.isAuthenticated {
                                    isSignInSuccessful = true
                                }
                    }
                }) {
                    Text("Sign in")
                        .font(.custom("Orbitron", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading)
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                }
                
                // Navigation link to TaskView
                
            }
            .padding(.horizontal, 24)
            .navigationBarHidden(true)
            .navigationDestination(isPresented:  $isSignInSuccessful) {
                TaskView()
            }
        }
    }
}

#Preview {
    SignInView()
}

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
    
    var body: some View {
        VStack(spacing: 32) {
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "envelope")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    TextField("", text: $email)
                        .font(.system(size: 16))
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "lock")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    SecureField("", text: $password)
                        .font(.system(size: 20))
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            
            // Sign In Button
            Button(action: {
                Task {
                    await viewModel.signIn(email: email, password: password)
                }
            }) {
                Text("Sign in")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isLoading)
            
            // Forgot Password Link
           
            if viewModel.isLoading {
                ProgressView()
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
}

#Preview {
    
        SignInView()
    
}

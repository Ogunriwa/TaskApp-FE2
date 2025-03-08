//
//  SignUpView.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 2/1/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 32) {
            // Email Field
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                        .frame(width: 24)
                    
                    TextField("", text: $email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            
            // Password Field
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.black)
                        .frame(width: 24)
                    
                    SecureField("", text: $password)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            
            // Confirm Password Field
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "eye.slash")
                        .foregroundColor(.black)
                        .frame(width: 24)
                    
                    SecureField("", text: $confirmPassword)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            // Sign Up Button
            Button(action: {
                Task {
                    await signUp()
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isLoading || !isValidInput)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
    }
    
    private var isValidInput: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        password == confirmPassword &&
        email.contains("@")
    }
    
    private func signUp() async {
        guard isValidInput else { return }
        await viewModel.signUp(
            username: email.components(separatedBy: "@").first ?? "",
            email: email,
            password: password,
            confirmPassword: confirmPassword
        )
        if viewModel.errorMessage == nil {
            dismiss()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

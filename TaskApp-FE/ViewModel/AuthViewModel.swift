//
//  AuthViewModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 2/1/25.
//

import Foundation

struct AuthCredentials: Codable {
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let token: String
    let user: AuthUser
}

struct AuthUser: Codable {
    let id: UUID
    let email: String
}


@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let credentials = AuthCredentials(email: email, password: password)
                let response = try await httpClient.signIn(credentials)
                // Save token and update authentication state
                isAuthenticated = true
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = handleError(error)
            }
        }
    }
    
    func signUp(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let credentials = AuthCredentials(email: email, password: password)
                let response = try await httpClient.signUp(credentials)
                // Save token and update authentication state
                isAuthenticated = true
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) -> String {
        if let httpError = error as? HTTPError {
            switch httpError {
            case .invalidURL:
                return "Invalid URL. Please try again."
            case .noData:
                return "No data received from the server."
            case .decodingError:
                return "Error processing server response."
            case .encodingError:
                return "Error preparing request."
            case .networkError(let underlyingError):
                return "Network error: \(underlyingError.localizedDescription)"
            case .serverError(let statusCode):
                return "Server error (\(statusCode)). Please try again."
            }
        }
        return "An unexpected error occurred. Please try again."
    }
}

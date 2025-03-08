import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var currentUser: UserDTO.Public?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
        checkAuthenticationState()
    }
    
    private func checkAuthenticationState() {
        if TokenManager.getToken() != nil {
            Task {
                await fetchCurrentUser()
            }
        }
    }
    
    func signUp(username: String, email: String, password: String, confirmPassword: String) async {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let credentials = SignUpCredentials(username: username, email: email, password: password, confirmPassword: confirmPassword)
                currentUser = try await httpClient.signUp(credentials: credentials)
                // Note: We don't set isAuthenticated here because the backend doesn't return a token on sign-up
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = handleError(error)
            }
        }
    }
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let credentials = LoginCredentials(email: email, password: password)
                let token = try await httpClient.signIn(credentials: credentials)
                TokenManager.saveToken(token.value)
                await fetchCurrentUser()
                isAuthenticated = true
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = handleError(error)
            }
        }
    }
    
    func signOut() async {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                try await httpClient.signOut()
                TokenManager.deleteToken()
                currentUser = nil
                isAuthenticated = false
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = handleError(error)
            }
        }
    }
    
    private func fetchCurrentUser() async {
        do {
            currentUser = try await httpClient.getCurrentUser()
            isAuthenticated = true
        } catch {
            TokenManager.deleteToken()
            isAuthenticated = false
            errorMessage = handleError(error)
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

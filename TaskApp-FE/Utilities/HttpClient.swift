//
//  HttpClient.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/26/25.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case noData
    case decodingError
    case encodingError
    case networkError(Error)
    case serverError(Int)
}

class HTTPClient {
    private let session: URLSession
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder
    
    init(session: URLSession = .shared) {
        self.session = session
        
        self.jsonEncoder = JSONEncoder()
        self.jsonEncoder.dateEncodingStrategy = .iso8601
        
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.dateDecodingStrategy = .iso8601
    }
    
    // FETCH TASKS
    
    func fetch() async throws -> [TaskItem] {
        let url = URL(string: APIEndpoints.Tasks.fetch)!
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.networkError(URLError(.badServerResponse))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw HTTPError.serverError(httpResponse.statusCode)
        }
        
        do {
            let tasks = try jsonDecoder.decode([TaskItem].self, from: data)
            return tasks
        } catch {
            throw HTTPError.decodingError
        }
    }
    // ADD OR CREATE TASK
    func create(_ task: TaskItem) async throws -> TaskItem {
        let url = URL(string: APIEndpoints.Tasks.create)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try jsonEncoder.encode(task)
        } catch {
            throw HTTPError.encodingError
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.networkError(URLError(.badServerResponse))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw HTTPError.serverError(httpResponse.statusCode)
        }
        
        do {
            let createdTask = try jsonDecoder.decode(TaskItem.self, from: data)
            return createdTask
        } catch {
            throw HTTPError.decodingError
        }
    }
    
    // EDIT TASKS
    
    func update(_ task: TaskItem) async throws -> TaskItem {
        let url = URL(string: APIEndpoints.Tasks.update(task.id))!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try jsonEncoder.encode(task)
        } catch {
            throw HTTPError.encodingError
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.networkError(URLError(.badServerResponse))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw HTTPError.serverError(httpResponse.statusCode)
        }
        
        do {
            let updatedTask = try jsonDecoder.decode(TaskItem.self, from: data)
            return updatedTask
        } catch {
            throw HTTPError.decodingError
        }
    }
    
    // DELETE TASKS
    
    func delete(_ id: Int64) async throws {
        let url = URL(string: APIEndpoints.Tasks.delete(id))!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.networkError(URLError(.badServerResponse))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw HTTPError.serverError(httpResponse.statusCode)
        }
    }
}


// AUTHENTICATION
extension HTTPClient {
    func signUp(credentials: SignUpCredentials) async throws -> UserDTO.Public {
            let url = URL(string: APIEndpoints.Auth.register)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = try jsonEncoder.encode(credentials)
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.networkError(URLError(.badServerResponse))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw HTTPError.serverError(httpResponse.statusCode)
            }
            
            return try jsonDecoder.decode(UserDTO.Public.self, from: data)
    }
    
    func signIn(credentials: LoginCredentials) async throws -> UserToken {
            let url = URL(string: APIEndpoints.Auth.login)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = try jsonEncoder.encode(credentials)
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.networkError(URLError(.badServerResponse))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw HTTPError.serverError(httpResponse.statusCode)
            }
            
            return try jsonDecoder.decode(UserToken.self, from: data)
    }
    
    func signOut() async throws {
            let url = URL(string: APIEndpoints.Auth.logout)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(TokenManager.getToken() ?? "")", forHTTPHeaderField: "Authorization")
            
            let (_, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.networkError(URLError(.badServerResponse))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw HTTPError.serverError(httpResponse.statusCode)
            }
    }
    
    func getCurrentUser() async throws -> UserDTO.Public {
            let url = URL(string: APIEndpoints.Auth.currentUser)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(TokenManager.getToken() ?? "")", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.networkError(URLError(.badServerResponse))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw HTTPError.serverError(httpResponse.statusCode)
            }
            
            return try jsonDecoder.decode(UserDTO.Public.self, from: data)
        }
    
    
}


extension HTTPClient {
    
    
}

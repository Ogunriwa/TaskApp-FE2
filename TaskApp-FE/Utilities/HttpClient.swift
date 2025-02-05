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
    
    func delete(_ id: UUID) async throws {
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
    func signIn(_ credentials: AuthCredentials) async throws -> AuthResponse {
        guard let url = URL(string: APIEndpoints.Auth.login) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try jsonEncoder.encode(credentials)
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
            let authResponse = try jsonDecoder.decode(AuthResponse.self, from: data)
            return authResponse
        } catch {
            throw HTTPError.decodingError
        }
    }
    
    func signUp(_ credentials: AuthCredentials) async throws -> AuthResponse {
        guard let url = URL(string: APIEndpoints.Auth.register) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try jsonEncoder.encode(credentials)
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
            let authResponse = try jsonDecoder.decode(AuthResponse.self, from: data)
            return authResponse
        } catch {
            throw HTTPError.decodingError
        }
    }
}

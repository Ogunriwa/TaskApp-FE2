//
//  Constants.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/26/25.

import Foundation

struct APIEndpoints {
    static let baseURL = "https://cf8b-184-104-233-33.ngrok-free.app" // Replace with your actual base URL
    
    struct Tasks {
        static let fetch = "\(baseURL)/tasks"
        static let create = "\(baseURL)/tasks"
        static func update(_ id: UUID) -> String { "\(baseURL)/tasks/\(id)" }
        static func delete(_ id: UUID) -> String { "\(baseURL)/tasks/\(id)" }
    }
    
    struct Auth {
        static let login = "\(baseURL)/auth/login"
        static let register = "\(baseURL)/auth/register"
        static let refreshToken = "\(baseURL)/auth/refresh"
        static let logout = "\(baseURL)/auth/logout"
    }
    
    struct User {
        static let profile = "\(baseURL)/user/profile"
        static func updateProfile(_ id: UUID) -> String { "\(baseURL)/user/\(id)" }
    }
}

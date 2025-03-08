//
//  Constants.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/26/25.



import Foundation

struct APIEndpoints {
    static let baseURL = "https://your-api-base-url.com" // Replace with your actual base URL
    
    struct Auth {
        static let register = "\(baseURL)/signin"
        static let login = "\(baseURL)/login"
        static let logout = "\(baseURL)/logout"
        static let currentUser = "\(baseURL)/user"
    }
    
    struct Tasks {
        static let fetch = "\(baseURL)/tasks"
        static let create = "\(baseURL)/tasks"
        static func update(_ id: Int64) -> String { "\(baseURL)/tasks/\(id)" }
        static func delete(_ id: Int64) -> String { "\(baseURL)/tasks/\(id)" }
    }
    struct User {
        static let profile = "\(baseURL)/user"
        static func updateProfile(_ id: Int64) -> String { "\(baseURL)/user/\(id)" }
    }
}

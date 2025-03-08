//
//  UserModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/21/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int64?
    let username: String
    let email: String
    // Note: We don't include passwordHash on the client side for security reasons
    
    // Add any additional properties that might be useful on the client side
    var taskListId: UUID?
}
struct UserDTO {
    struct Public: Codable {
        let id: Int64?
        let username: String
        let email: String
        let taskListId: UUID?
    }
}

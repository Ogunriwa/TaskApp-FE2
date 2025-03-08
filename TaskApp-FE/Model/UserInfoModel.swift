//
//  UserModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/21/25.
//
import Foundation

struct User: Codable, Identifiable {
    let id: Int64
    let username: String
    let email: String
}

struct UserDTO {
    struct Public: Codable {
        let id: Int64
        let username: String
        let email: String
        let taskListId: Int
    }
}

struct LoginCredentials: Codable {
    let email: String
    let password: String
}

struct SignUpCredentials: Codable {
    let username: String?
    let email: String
    let password: String
    let confirmPassword: String
}

struct UserToken: Codable {
    let value: String
    let userID: Int64
}


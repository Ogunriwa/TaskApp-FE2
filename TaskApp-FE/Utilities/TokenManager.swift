//
//  TokenManager.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 2/28/25.
//

import Foundation

class TokenManager {
    private static let tokenKey = "authToken"
    
    static func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static func deleteToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
}

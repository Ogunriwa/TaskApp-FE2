//
//  TaskModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/21/25.
//

import Foundation


struct TaskItem: Identifiable, Codable {
    let id: Int64
    let title: String
    let time: String
    var isCompleted: Bool
    var description: String?
}

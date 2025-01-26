//
//  TaskDetailsViewModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/26/25.
//

import Foundation


import Foundation

class TaskDetailsViewModel: ObservableObject {
    @Published var task: TaskItem
    let onDelete: () -> Void
    let onUpdate: (TaskItem) -> Void

    init(task: TaskItem, onDelete: @escaping () -> Void, onUpdate: @escaping (TaskItem) -> Void) {
        self.task = task
        self.onDelete = onDelete
        self.onUpdate = onUpdate
    }

    func updateDescription(_ description: String) {
        task.description = description.isEmpty ? nil : description
        onUpdate(task)
    }

    func toggleCompletion() {
        task.isCompleted.toggle()
        onUpdate(task)
    }

    func deleteTask() {
        onDelete()
    }
}

//
//  TaskViewModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/26/25.
//

import Foundation




import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    @Published var selectedTaskIndex: Int?
    @Published var showingTaskDetails = false
    @Published var showingNewTaskSheet = false

    init() {
        // Initialize with some sample tasks
        tasks = [
            TaskItem(title: "Carry out groceries", time: "Mon 8:45am", isCompleted: false, description: nil),
            TaskItem(title: "Task 1", time: "Mon 8:45am", isCompleted: true, description: "Sample description")
        ]
    }

    func addTask(_ task: TaskItem) {
        tasks.append(task)
    }

    func updateTask(at index: Int, with task: TaskItem) {
        guard index >= 0 && index < tasks.count else { return }
        tasks[index] = task
    }

    func deleteTask(at index: Int) {
        guard index >= 0 && index < tasks.count else { return }
        tasks.remove(at: index)
    }

    func toggleTaskCompletion(at index: Int) {
        guard index >= 0 && index < tasks.count else { return }
        tasks[index].isCompleted.toggle()
    }

    func selectTask(at index: Int) {
        selectedTaskIndex = index
        showingTaskDetails = true
    }

    func showNewTaskSheet() {
        showingNewTaskSheet = true
    }
}

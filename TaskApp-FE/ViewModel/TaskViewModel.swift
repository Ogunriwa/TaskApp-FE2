//
//  TaskViewModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/26/25.
//
import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let httpClient = HTTPClient()
    
    // Fetch all tasks
    func fetchTasks() async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            let fetchedTasks = try await httpClient.fetch()
            await MainActor.run {
                self.tasks = fetchedTasks
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load tasks: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    // Add a new task
    func addTask(_ task: TaskItem) async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            let newTask = try await httpClient.create(task)
            await MainActor.run {
                self.tasks.append(newTask)
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to add task: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    // Update an existing task
    func updateTask(_ task: TaskItem) async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            let updatedTask = try await httpClient.update(task)
            await MainActor.run {
                if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                    self.tasks[index] = updatedTask
                }
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to update task: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    // Delete a task
    func deleteTask(id: Int64) async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            try await httpClient.delete(id)
            await MainActor.run {
                self.tasks.removeAll { $0.id == id }
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to delete task: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    // Toggle task completion status
    func toggleTaskCompletion(_ task: TaskItem) async {
        var updatedTask = task
        updatedTask.isCompleted.toggle()
        await updateTask(updatedTask)
    }
}

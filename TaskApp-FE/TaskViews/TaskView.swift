//
//  TaskListView.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/21/25.
//
import SwiftUI


struct TaskView: View {
    
    
    @StateObject private var viewModel = TaskViewModel()
    @State private var tasks: [TaskItem] = [
        TaskItem(title: "Carry out groceries", time: "Mon 8:45am", isCompleted: false),
        TaskItem(title: "Task 1", time: "Mon 8:45am", isCompleted: true)
    ]
    
    
    @State private var showingTaskDetails = false
    @State private var showingNewTaskSheet = false
    @State private var selectedTask: TaskItem?
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Tasks")
                    .font(.system(size: 32, weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Task List
            VStack(spacing: 0) {
                ForEach(tasks) { task in
                    TaskRowView(task: task)
                        .onTapGesture {
                            selectedTask = task
                            showingTaskDetails = true
                        }
                    Divider()
                        .background(Color.black)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Add Button
            Button(action: {
                showingNewTaskSheet = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $showingNewTaskSheet) {
            AddTaskView { newTask in
                tasks.append(newTask)
            }
        }
        .sheet(isPresented: $showingTaskDetails, content: {
            if let task = selectedTask {
                TaskDetailSheet(
                    task: task,
                    onDelete: {
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks.remove(at: index)
                        }
                    },
                    onToggleComplete: {
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks[index].isCompleted.toggle()
                        }
                    }
                )
            }
        })
    }
}

#Preview {
    TaskView()
}

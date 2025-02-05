//
//  AddTaskViewModel.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/26/25.
//

import Foundation


class AddTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var time: String = ""
    @Published var description: String = ""

    let onAddTask: (TaskItem) -> Void

    init(onAddTask: @escaping (TaskItem) -> Void) {
        self.onAddTask = onAddTask
    }

    func addTask() {
        let newTask = TaskItem(
            title: title,
            time: time,
            isCompleted: false,
            description: description.isEmpty ? nil : description
        )
        onAddTask(newTask)
    }
}

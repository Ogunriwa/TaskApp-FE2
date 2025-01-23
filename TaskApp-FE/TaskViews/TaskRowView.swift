//
//  TaskRowView.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/21/25.
//

import SwiftUI
struct TaskRowView: View {
    let task: TaskItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.system(size: 18))
                Text(task.time)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: task.isCompleted ? "checkmark" : "clock")
                .foregroundColor(.black)
                .font(.system(size: 20))
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    TaskRowView(task: TaskItem(title: "Task 1", time: "Mon 8:45am", isCompleted: false))
}

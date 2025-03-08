//
//  TaskDetailsView.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/22/25.
//

import SwiftUI

struct TaskDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    let task: TaskItem
    var onDelete: () -> Void
    var onToggleComplete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header section
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(task.title)
                        .font(.system(size: 24, weight: .bold))
                        .textCase(.uppercase)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: onToggleComplete) {
                            Image(systemName: task.isCompleted ? "checkmark" : "clock")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                        }
                    }
                }
                
                Text(task.time)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            .padding(.top, 30)
            
            // Description
            Text("Carry out the grocerie and mkekfwmriegnt cewfvgfrgettbbgbtbebetgbettbbbt rbegtbhhjySs")
                .font(.system(size: 16))
                .lineSpacing(4)
            
            Spacer()
            
            // Bottom buttons
            HStack {
                Button(action: {
                    // Save action
                    dismiss()
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {
                    onDelete()
                    dismiss()
                }) {
                    Image(systemName: "trash")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 30)
        }
        .padding()
    }
}

#Preview {
    TaskDetailSheet(
        task: TaskItem(
            id: 45,
            title: "Carry out groceries",
            time: "Mon 8:45am",
            isCompleted: false
        ),
        onDelete: {},
        onToggleComplete: {}
    )
}

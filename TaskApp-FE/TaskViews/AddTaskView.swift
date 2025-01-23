//
//  AddTaskView.swift
//  TaskApp-FE
//
//  Created by Ibrahim Arogundade on 1/23/25.
//

import SwiftUI

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var time: String = "Mon 8:45am" // This would typically come from a date picker
    
    var onSave: (TaskItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Title Section
            VStack(alignment: .leading, spacing: 8) {
                Text("TITLE")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                
                Text(time)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                
                TextField("", text: $title)
                    .font(.system(size: 18))
                    .textFieldStyle(PlainTextFieldStyle())
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            .padding(.top, 40)
            
            Spacer()
            
            // Bottom Buttons
            HStack {
                Button(action: {
                    let newTask = TaskItem(
                        title: title,
                        time: time,
                        isCompleted: false
                    )
                    onSave(newTask)
                    dismiss()
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}
#Preview {
    AddTaskView(onSave: { _ in })
}

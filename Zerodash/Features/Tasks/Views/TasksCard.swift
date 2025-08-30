//
//  TasksCard.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//


// Features/Tasks/Views/TasksCard.swift
import SwiftUI

struct TasksCard: View {
    var model: TasksModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tasks").font(.headline)
            if model.items.isEmpty {
                Text("No tasks").foregroundStyle(.secondary)
            }
        }
        .cardStyle()
    }
}

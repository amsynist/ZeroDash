////
////  TodaysDashCard.swift
////  Zerodash
////
////  Created by CA on 27/08/25.
////
//
//import SwiftUI
//
//// MARK: - Today's Dashboard Card
//struct TodaysDashCard: View {
//    @ObservedObject var taskManager: TaskManager
//
//    var todaysTasks: [TaskItem] {
//        let today = Calendar.current.startOfDay(for: Date())
//        let tomorrow = Calendar.current.date(
//            byAdding: .day,
//            value: 1,
//            to: today
//        )!
//
//        return taskManager.tasks.filter { task in
//            task.createdAt >= today && task.createdAt < tomorrow
//        }
//    }
//
//    var todaysCompletedTasks: Int {
//        todaysTasks.filter { $0.isCompleted }.count
//    }
//
//    var todaysPendingTasks: Int {
//        todaysTasks.filter { !$0.isCompleted }.count
//    }
//
//    var completionPercentage: Double {
//        guard !todaysTasks.isEmpty else { return 0 }
//        return Double(todaysCompletedTasks) / Double(todaysTasks.count) * 100
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            // Header
//            HStack {
//                HStack(spacing: 12) {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(.green.opacity(0.2))
//                            .frame(width: 32, height: 32)
//
//                        Image(systemName: "calendar.badge.checkmark")
//                            .foregroundColor(.green)
//                            .font(.system(size: 16))
//                    }
//
//                    VStack(alignment: .leading, spacing: 2) {
//                        Text("TODAY'S DASH")
//                            .foregroundColor(.white)
//                            .font(.system(size: 12, weight: .bold))
//
//                        Text("Daily progress...")
//                            .foregroundColor(.white.opacity(0.6))
//                            .font(.system(size: 11))
//                    }
//                }
//
//                Spacer()
//
//                // Status indicator
//                HStack(spacing: 4) {
//                    Circle()
//                        .fill(todaysPendingTasks > 0 ? .orange : .green)
//                        .frame(width: 6, height: 6)
//
//                    Text(todaysPendingTasks > 0 ? "IN PROGRESS" : "COMPLETED")
//                        .foregroundColor(
//                            todaysPendingTasks > 0 ? .orange : .green
//                        )
//                        .font(.system(size: 10, weight: .bold))
//                }
//            }
//
//            // Progress Section
//            VStack(alignment: .leading, spacing: 12) {
//                HStack {
//                    Text("Today's Progress")
//                        .foregroundColor(.white)
//                        .font(.system(size: 14, weight: .semibold))
//
//                    Spacer()
//
//                    Text("\(Int(completionPercentage))%")
//                        .foregroundColor(.white)
//                        .font(.system(size: 14, weight: .bold))
//                }
//
//                // Progress bar
//                GeometryReader { geometry in
//                    ZStack(alignment: .leading) {
//                        RoundedRectangle(cornerRadius: 4)
//                            .fill(.white.opacity(0.1))
//                            .frame(height: 8)
//
//                        RoundedRectangle(cornerRadius: 4)
//                            .fill(
//                                LinearGradient(
//                                    colors: [.green, .green.opacity(0.7)],
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .frame(
//                                width: geometry.size.width
//                                    * (completionPercentage / 100),
//                                height: 8
//                            )
//                    }
//                }
//                .frame(height: 8)
//            }
//
//            // Quick Actions or Empty State
//            if !todaysTasks.isEmpty {
//                HStack {
//                    Button(action: {
//                        // Mark all as complete
//                        for task in todaysTasks where !task.isCompleted {
//                            taskManager.toggleTask(task.id)
//                        }
//                    }) {
//                        HStack(spacing: 6) {
//                            Image(systemName: "checkmark.circle")
//                                .font(.system(size: 12))
//                            Text("Complete All")
//                                .font(.system(size: 12, weight: .medium))
//                        }
//                        .foregroundColor(.green)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 8)
//                        .background(.green.opacity(0.1))
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                    .disabled(todaysPendingTasks == 0)
//
//                    Spacer()
//
//                    Button(action: {
//                        taskManager.addTask(
//                            title: "New Task",
//                            description: "Task for today"
//                        )
//                    }) {
//                        HStack(spacing: 6) {
//                            Image(systemName: "plus.circle")
//                                .font(.system(size: 12))
//                            Text("Add Task")
//                                .font(.system(size: 12, weight: .medium))
//                        }
//                        .foregroundColor(.blue)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 8)
//                        .background(.blue.opacity(0.1))
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                }
//            } else {
//                // Empty state
//                VStack(spacing: 8) {
//                    Image(systemName: "calendar.badge.plus")
//                        .foregroundColor(.white.opacity(0.4))
//                        .font(.system(size: 20))
//
//                    Text("No tasks for today")
//                        .foregroundColor(.white.opacity(0.6))
//                        .font(.system(size: 12))
//
//                    Button("Add First Task") {
//                        taskManager.addTask(
//                            title: "New Task",
//                            description: "Task for today"
//                        )
//                    }
//                    .foregroundColor(.blue)
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 6)
//                    .background(.blue.opacity(0.1))
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                    .font(.system(size: 12, weight: .medium))
//                }
//                .frame(maxWidth: .infinity)
//            }
//        }
//        .padding(20)
//        .background(.gray.opacity(0.1))
//        .clipShape(RoundedRectangle(cornerRadius: 16))
//    }
//}
//
//// MARK: - Previews
//#Preview {
//    TodaysDashCard(taskManager: TaskManager.preview)
//        .preferredColorScheme(.dark)
//        .padding()
//        .background(.black)
//}
//
//#Preview("Empty State") {
//    TodaysDashCard(taskManager: TaskManager.emptyPreview)
//        .preferredColorScheme(.dark)
//        .padding()
//        .background(.black)
//}

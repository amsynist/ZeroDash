//
//  TaskOverviewCard.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//


//import SwiftUI
//
//struct TaskOverviewCard: View {
//    var body: some View {
//        CardContainer {
//            HStack {
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("Today's Progress")
//                        .font(.headline.weight(.semibold))
//                    
//                    HStack {
//                        VStack(alignment: .leading, spacing: 2) {
//                            Text("75%")
//                                .font(.title.weight(.bold))
//                                .foregroundStyle(.green)
//                            Text("Completion")
//                                .font(.caption)
//                                .foregroundStyle(.secondary)
//                        }
//                        
//                        Spacer()
//                        
//                        VStack(alignment: .trailing, spacing: 2) {
//                            Text("6 of 8")
//                                .font(.subheadline.weight(.semibold))
//                            Text("Tasks Done")
//                                .font(.caption)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//                }
//                
//                Spacer()
//                
//                // Progress Ring
//                ZStack {
//                    Circle()
//                        .stroke(.tertiary, lineWidth: 6)
//                        .frame(width: 60, height: 60)
//                    
//                    Circle()
//                        .trim(from: 0, to: 0.75)
//                        .stroke(.green.gradient, style: StrokeStyle(lineWidth: 6, lineCap: .round))
//                        .frame(width: 60, height: 60)
//                        .rotationEffect(.degrees(-90))
//                }
//            }
//        }
//    }
//}

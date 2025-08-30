////
////  NeonToggleStyled.swift
////  Zerodash
////
////  Created by CA on 28/08/25.
////
//
//
////
////  Styles.swift
////  Zerodash
////
////  Replaces the previous file – adds snappier NeonToggleStyle
////
//
//import KeyboardShortcuts
//import SwiftUI
//
//// MARK: – Toggle style (no-lag thumb animation)
//struct NeonToggleStyled: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        HStack {
//            configuration.label  // keeps any leading text
//            Spacer()
//
//            // Entire switch is one Button so the whole area is clickable
//            Button {
//                withAnimation(.interpolatingSpring(stiffness: 260, damping: 24))
//                {
//                    configuration.isOn.toggle()
//                }
//            } label: {
//                ZStack(alignment: configuration.isOn ? .trailing : .leading) {
//
//                    // Track --------------------------------------------------
//                    Capsule()
//                        .fill(trackGradient(configuration.isOn))
//                        .frame(width: 50, height: 28)
//                        .overlay(  // subtle inner stroke
//                            Capsule()
//                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
//                        )
//                        .shadow(
//                            color: .black.opacity(0.25),
//                            radius: 3,
//                            y: 2
//                        )
//
//                    // Thumb --------------------------------------------------
//                    Circle()
//                        .fill(Color.white)  // white base
//                        .frame(width: 24, height: 24)
//                        .overlay(  // coloured core
//                            Circle()
//                                .fill(
//                                    configuration.isOn
//                                        ? Color.green
//                                        : Color.gray.opacity(0.65)
//                                )
//                                .frame(width: 14, height: 14)
//                        )
//                        .shadow(
//                            color: configuration.isOn
//                                ? Color.green.opacity(0.55)
//                                : .clear,
//                            radius: 6
//                        )
//                        .padding(2)
//                        .scaleEffect(configuration.isOn ? 1.0 : 0.92)  // press-feel
//                }
//            }
//            .buttonStyle(.plain)  // remove default button tint
//            .contentShape(Rectangle())  // full area is tappable
//        }
//        .padding(.vertical, 4)
//    }
//
//    // MARK: – Helpers ---------------------------------------------------------
//    private func trackGradient(_ isOn: Bool) -> LinearGradient {
//        let onColors = [Color.green.opacity(0.7), Color.green]
//        let offColors = [Color.gray.opacity(0.35), Color.gray.opacity(0.6)]
//        return LinearGradient(
//            colors: isOn ? onColors : offColors,
//            startPoint: .top,
//            endPoint: .bottom
//        )
//    }
//}
//
//
//

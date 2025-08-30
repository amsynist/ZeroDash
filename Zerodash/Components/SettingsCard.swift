//
//  SettingsCard.swift
//  Zerodash
//
//  Entire file replaced – instant toggles + unified glass aesthetic
//

import KeyboardShortcuts
import SwiftUI
//
//struct SettingsCard: View {
//    @EnvironmentObject var hotkeyManager: HotkeyWindowManager
//    let settingsReady: Bool
//    var dismissAction: () -> Void
//    var shortcut: KeyboardShortcuts.Name
//
//    @State private var startAtLogin = false
//    @State private var showMenuBarIcon = true
//    @State private var enableAnimations = true
//
//    @State private var showHotkeyWarning = false
//    @State private var warningMessage = ""
//
//    var body: some View {
//        VStack(spacing: 0) {
//            // Header
//            HStack(spacing: 12) {
//                Image(systemName: "gearshape.fill")
//                    .font(.title2)
//                    .foregroundStyle(.blue.gradient)
//                Text("ZeroDash Settings")
//                    .font(.title2.weight(.semibold))
//                Spacer()
//                Button(action: dismissAction) {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title3)
//                        .foregroundStyle(.secondary)
//                }
//                .buttonStyle(.plain)
//            }
//            .padding(.top, 24)
//            .padding(.horizontal, 30)
//            .padding(.bottom, 18)
//            .background(.ultraThinMaterial)
//
//            Divider()
//
//            // Scrollable Content
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(alignment: .leading, spacing: 24) {
//
//                    Label("Keyboard Shortcuts", systemImage: "keyboard")
//                        .font(.title3.weight(.semibold))
//                        .foregroundStyle(.primary)
//                    HotkeyRecorderStyled(
//                            title: "Toggle Dashboard",
//                            name: .toggleDashboard
//                        ) { new in
//                            hotkeyManager.validateHotkey()
//                        }
//                    SectionBlock(
//                        title: "Behavior",
//                        systemImage: "slider.horizontal.3"
//                    ) {
//                        Toggle(
//                            "Hide when clicking outside",
//                            isOn: $hotkeyManager.hideOnClickOutside
//                        )
//                        .toggleStyle(NeonToggleStyled())
//                        Toggle(
//                            "Hide when pressing Escape",
//                            isOn: $hotkeyManager.hideOnEscape
//                        )
//                        .toggleStyle(NeonToggleStyled())
//                    }
//
//                    SectionBlock(title: "Advanced", systemImage: "gearshape.2")
//                    {
//                        Toggle("Start at Login", isOn: $startAtLogin)
//                            .toggleStyle(NeonToggleStyled())
//                        Toggle("Show Menu-bar Icon", isOn: $showMenuBarIcon)
//                            .toggleStyle(NeonToggleStyled())
//                        Toggle("Enable Animations", isOn: $enableAnimations)
//                            .toggleStyle(NeonToggleStyled())
//                    }
//
//                    Spacer(minLength: 20)
//                }
//                .padding(24)
//            }
//            Divider()
//
//            // Footer
//            Text("Press your configured hotkey anywhere to show ZeroDash")
//                .font(.subheadline)
//                .foregroundStyle(.secondary)
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 16)
//                .background(.ultraThinMaterial)
//        }
//        .frame(width: 780, height: 600)
//        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
//    }
//}
//
//// MARK: – Sub-components  (unchanged except style tweaks)
//private struct SectionBlock<Content: View>: View {
//    var title: String
//    var systemImage: String
//
//    @ViewBuilder var content: () -> Content
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 14) {
//            Label(title, systemImage: systemImage)
//                .font(.title3.weight(.semibold))
//                .foregroundStyle(.primary)
//
//            VStack(alignment: .leading, spacing: 18, content: content)
//                .padding(20)
//                .background(
//                    // Glassy panel look
//                    RoundedRectangle(cornerRadius: 16, style: .continuous)
//                        .fill(.ultraThinMaterial)
//                        .background(
//                            LinearGradient(
//                                colors: [
//                                    Color.white.opacity(0.08),
//                                    Color.black.opacity(0.3),
//                                ],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        )
//                        .clipShape(
//                            RoundedRectangle(
//                                cornerRadius: 16,
//                                style: .continuous
//                            )
//                        )
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 16, style: .continuous)
//                        .strokeBorder(
//                            LinearGradient(
//                                colors: [
//                                    Color.white.opacity(0.25),
//                                    Color.white.opacity(0.05),
//                                ],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            ),
//                            lineWidth: 1
//                        )
//                )
//                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 6)
//        }
//
//    }
//}
//
//#Preview {
//    SettingsCard(
//        settingsReady: true,
//        dismissAction: {},
//        shortcut: .toggleDashboard
//    )
//    .environmentObject(HotkeyWindowManager())
//    .preferredColorScheme(.dark)
//    .padding()
//    .background(.black)
//}

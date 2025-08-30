////
////  HotkeyRecorderStyled.swift
////  Zerodash
////
////  Clean, immediate hotkey recorder with single bar design
////
//
//import Carbon
//import KeyboardShortcuts
//import SwiftUI
//
//// MARK: - Key Chip Component
//private struct KeyChip: View {
//    let text: String
//
//    var body: some View {
//        Text(text)
//            .font(.system(size: 13, weight: .semibold, design: .rounded))
//            .foregroundStyle(.white)
//            .padding(.horizontal, 10)
//            .padding(.vertical, 5)
//            .background(
//                Capsule()
//                    .fill(.ultraThinMaterial)
//                    .overlay(
//                        Capsule().stroke(.white.opacity(0.2), lineWidth: 1)
//                    )
//            )
//            .shadow(color: .black.opacity(0.3), radius: 4, y: 2)
//    }
//}
//
//// MARK: - Recording Pulse Animation
//private struct RecordingPulse: View {
//    @Binding var isActive: Bool
//
//    var body: some View {
//        ZStack {
//            Circle()
//                .fill(.green)
//                .frame(width: 8, height: 8)
//                .scaleEffect(isActive ? 1.2 : 1.0)
//                .opacity(isActive ? 0.8 : 0.6)
//
//            Circle()
//                .stroke(.green.opacity(0.6), lineWidth: 2)
//                .frame(width: 16, height: 16)
//                .scaleEffect(isActive ? 1.5 : 1.0)
//                .opacity(isActive ? 0.0 : 0.8)
//        }
//        .animation(
//            .easeInOut(duration: 1.0).repeatForever(autoreverses: true),
//            value: isActive
//        )
//    }
//}
//
//// MARK: - Immediate Key Monitor (Fixed for Swift 6)
//private class ImmediateKeyMonitor: ObservableObject {
//    private var globalMonitor: Any?
//    private var localMonitor: Any?
//    private var isActive = false
//
//    func startRecording(
//        onCancel: @escaping () -> Void,
//        onCapture: @escaping (KeyboardShortcuts.Shortcut) -> Void
//    ) {
//        guard !isActive else { return }
//        isActive = true
//
//        debugPrint("🎯 [HotkeyRecorder] Started recording")
//
//        // Monitor for clicks outside to cancel
//        globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: [
//            .leftMouseDown, .rightMouseDown,
//        ]) { [weak self] _ in
//            debugPrint("🎯 [HotkeyRecorder] Click outside detected - canceling")
//            Task { @MainActor in
//                self?.stopRecording()
//                onCancel()
//            }
//        }
//
//        // Monitor for key combinations
//        localMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown]) {
//            [weak self] event in
//            let modifiers = event.modifierFlags.intersection(
//                .deviceIndependentFlagsMask
//            )
//
//            // Must have at least one modifier
//            var shortcutModifiers: NSEvent.ModifierFlags = []
//            if modifiers.contains(.command) {
//                shortcutModifiers.insert(.command)
//            }
//            if modifiers.contains(.shift) { shortcutModifiers.insert(.shift) }
//            if modifiers.contains(.option) { shortcutModifiers.insert(.option) }
//            if modifiers.contains(.control) {
//                shortcutModifiers.insert(.control)
//            }
//
//            if !shortcutModifiers.isEmpty {
//                let key = KeyboardShortcuts.Key(rawValue: Int(event.keyCode))
//                let shortcut = KeyboardShortcuts.Shortcut(
//                    key,
//                    modifiers: shortcutModifiers
//                )
//
//                // Handle shortcut on main actor
//                Task { @MainActor in
//                    debugPrint(
//                        "🎯 [HotkeyRecorder] Captured: \(shortcut.description)"
//                    )
//                    self?.stopRecording()
//                    onCapture(shortcut)
//                }
//                return nil  // Consume the event
//            }
//
//            return event
//        }
//    }
//
//    @MainActor
//    func stopRecording() {
//        guard isActive else { return }
//        isActive = false
//
//        if let monitor = globalMonitor {
//            NSEvent.removeMonitor(monitor)
//            globalMonitor = nil
//        }
//
//        if let monitor = localMonitor {
//            NSEvent.removeMonitor(monitor)
//            localMonitor = nil
//        }
//
//        debugPrint("🎯 [HotkeyRecorder] Stopped recording")
//    }
//
//    // Fixed deinit - no self capture in closure
//    deinit {
//        // Clean up synchronously without capturing self
//        if let monitor = globalMonitor {
//            NSEvent.removeMonitor(monitor)
//        }
//        if let monitor = localMonitor {
//            NSEvent.removeMonitor(monitor)
//        }
//        debugPrint("🎯 [HotkeyRecorder] Monitor deinitialized")
//    }
//}
//
//// MARK: - Format Shortcut to Chips (Main Actor)
//@MainActor
//private func formatShortcut(_ shortcut: KeyboardShortcuts.Shortcut?) -> [String]
//{
//    guard let sc = shortcut else { return [] }
//
//    var chips: [String] = []
//    if sc.modifiers.contains(.command) { chips.append("⌘") }
//    if sc.modifiers.contains(.shift) { chips.append("⇧") }
//    if sc.modifiers.contains(.option) { chips.append("⌥") }
//    if sc.modifiers.contains(.control) { chips.append("⌃") }
//
//    // Format the key - safely access description on main actor
//    let keyString: String = {
//        let desc = sc.description
//        if desc.hasSuffix(" ") {
//            return "Space"
//        } else if desc.hasSuffix("\t") {
//            return "Tab"
//        } else if desc.count == 1 {
//            return desc.uppercased()
//        } else {
//            return desc
//        }
//    }()
//
//    chips.append(keyString)
//    return chips
//}
//
//// MARK: - Main Recorder Component
//struct HotkeyRecorderStyled: View {
//    let title: String
//    let name: KeyboardShortcuts.Name
//    let onChange: (KeyboardShortcuts.Shortcut?) -> Void
//    // Add this to your HotkeyRecorderStyled struct
//    @State private var isInitialized = false
//    @State private var currentShortcut: KeyboardShortcuts.Shortcut?
//    @State private var isRecording = false
//    @State private var isHovering = false
//    @StateObject private var keyMonitor = ImmediateKeyMonitor()
//
//    // Default shortcut - never allow empty
//    private let defaultShortcut = KeyboardShortcuts.Shortcut(
//        .space,
//        modifiers: [.command]
//    )
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // Single clean bar
//            HStack(spacing: 0) {
//                // Left section: Icon + Status/Chips
//                HStack(spacing: 12) {
//                    // Icon
//                    Group {
//                        if isRecording {
//                            RecordingPulse(isActive: $isRecording)
//                        } else {
//                            Image(systemName: "keyboard")
//                                .font(.system(size: 16, weight: .semibold))
//                                .foregroundStyle(.primary)
//                        }
//                    }
//                    .frame(width: 20, height: 20)
//                    
//                    // Shortcut chips or status text
//                    HStack(spacing: 8) {
//                        if let shortcut = currentShortcut, !isRecording {
//                            // Show current shortcut chips when not recording
//                            ForEach(formatShortcut(shortcut), id: \.self) { chip in
//                                KeyChip(text: chip)
//                            }
//                        } else {
//                            // Show recording status text
//                            Text(isRecording ? "Recording..." : "Tap to record")
//                                .font(.system(size: 13, weight: .medium, design: .rounded))
//                                .foregroundStyle(isRecording ? .green : .secondary)
//                                .animation(.easeInOut(duration: 0.2), value: isRecording)
//                        }
//                    }
//                    .frame(minHeight: 26)
//                    .animation(.easeInOut(duration: 0.15), value: isRecording)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                
//                // Center section: Title (only when not recording)
//                if !isRecording {
//                    Text(title)
//                        .font(.system(size: 15, weight: .semibold, design: .rounded))
//                        .foregroundStyle(.primary)
//                        .opacity(0.4)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .transition(.opacity.combined(with: .scale(scale: 0.95)))
//                        .animation(.easeInOut(duration: 0.25), value: isRecording)
//                } else {
//                    // Empty space during recording to maintain layout
//                    Spacer()
//                        .frame(maxWidth: .infinity)
//                }
//                
//                // Right section: Reset button - Updated styling
//                HStack {
//                    Spacer()
//                    Button {
//                        resetToDefault()
//                    } label: {
//                        HStack(spacing: 4) {
//                            Image(systemName: "arrow.counterclockwise")
//                                .font(.system(size: 10, weight: .semibold))
//                            Text("Reset")
//                                .font(.system(size: 11, weight: .semibold, design: .rounded))
//                        }
//                        .foregroundStyle(.white.opacity(0.9))
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                        .background(
//                            Capsule()
//                                .fill(
//                                    LinearGradient(
//                                        colors: [
//                                            Color.orange.opacity(0.8),
//                                            Color.orange.opacity(0.6)
//                                        ],
//                                        startPoint: .topLeading,
//                                        endPoint: .bottomTrailing
//                                    )
//                                )
//                                .overlay(
//                                    Capsule()
//                                        .stroke(
//                                            LinearGradient(
//                                                colors: [
//                                                    Color.white.opacity(0.3),
//                                                    Color.orange.opacity(0.4)
//                                                ],
//                                                startPoint: .topLeading,
//                                                endPoint: .bottomTrailing
//                                            ),
//                                            lineWidth: 1
//                                        )
//                                )
//                                .shadow(color: .orange.opacity(0.3), radius: 4, y: 2)
//                        )
//                    }
//                    .buttonStyle(.plain)
//                    .opacity((currentShortcut != nil && currentShortcut != defaultShortcut) ? 1.0 : 0.4)
//                    .scaleEffect((currentShortcut != nil && currentShortcut != defaultShortcut) ? 1.0 : 0.95)
//                    .animation(.easeInOut(duration: 0.2), value: currentShortcut != nil)
//                    .onHover { hovering in
//                        if hovering {
//                            NSCursor.pointingHand.push()
//                        } else {
//                            NSCursor.pop()
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .trailing)
//            }
//            .padding(.horizontal, 18)
//            .padding(.vertical, 16)
//            .frame(minHeight: 58)
//            .background(
//                RoundedRectangle(cornerRadius: 14, style: .continuous)
//                    .fill(.ultraThinMaterial)
//                    .background(
//                        RoundedRectangle(cornerRadius: 14, style: .continuous)
//                            .fill(
//                                LinearGradient(
//                                    colors: [
//                                        Color.white.opacity(0.08),
//                                        Color.black.opacity(0.2)
//                                    ],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                )
//                            )
//                    )
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 14, style: .continuous)
//                            .stroke(
//                                LinearGradient(
//                                    colors: isRecording
//                                        ? [.green.opacity(0.6), .green.opacity(0.2)]
//                                        : [.white.opacity(0.25), .white.opacity(0.05)],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                ),
//                                lineWidth: 1.5
//                            )
//                    )
//            )
//            .scaleEffect(isRecording ? 1.005 : (isHovering ? 1.002 : 1.0))
//            .shadow(
//                color: isRecording ? .green.opacity(0.3) : .black.opacity(0.25),
//                radius: isRecording ? 12 : 6,
//                x: 0,
//                y: 3
//            )
//            .animation(.spring(response: 0.35, dampingFraction: 0.75), value: isRecording)
//            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isHovering)
//            .onHover { hovering in
//                isHovering = hovering
//                if hovering {
//                    NSCursor.pointingHand.push()
//                } else {
//                    NSCursor.pop()
//                }
//            }
//            .contentShape(Rectangle())
//            .onTapGesture {
//                guard isInitialized else {
//                    debugPrint("🎯 [HotkeyRecorder] Component not yet initialized, ignoring tap")
//                    return
//                }
//
//                if isRecording {
//                    debugPrint("🎯 [HotkeyRecorder] User tapped to stop recording")
//                    keyMonitor.stopRecording()
//                    isRecording = false
//                } else {
//                    debugPrint("🎯 [HotkeyRecorder] User tapped to start recording")
//                    startRecording()
//                }
//            }
//        }
//        .onAppear {
//            // Small delay to ensure proper initialization
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                loadCurrentShortcut()
//                isInitialized = true
//                debugPrint("🎯 [HotkeyRecorder] Component fully initialized")
//            }
//        }
//    }
//
//    // MARK: - Actions
//    private func loadCurrentShortcut() {
//        let shortcut = KeyboardShortcuts.getShortcut(for: name)
//
//        // If no shortcut exists, set default immediately
//        if shortcut == nil {
//            debugPrint("🎯 [HotkeyRecorder] No shortcut found, setting default")
//            KeyboardShortcuts.setShortcut(defaultShortcut, for: name)
//            currentShortcut = defaultShortcut
//            onChange(defaultShortcut)
//        } else {
//            currentShortcut = shortcut
//            debugPrint(
//                "🎯 [HotkeyRecorder] Loaded shortcut: \(shortcut?.description ?? "nil")"
//            )
//        }
//    }
//
//    private func startRecording() {
//        guard !isRecording else { return }
//
//        debugPrint("🎯 [HotkeyRecorder] Starting recording...")
//        isRecording = true
//
//        keyMonitor.startRecording(
//            onCancel: {
//                debugPrint("🎯 [HotkeyRecorder] Recording canceled")
//                isRecording = false
//            },
//            onCapture: { shortcut in
//                debugPrint(
//                    "🎯 [HotkeyRecorder] Setting new shortcut: \(shortcut.description)"
//                )
//
//                // Set immediately - no delay
//                KeyboardShortcuts.setShortcut(shortcut, for: name)
//                currentShortcut = shortcut
//                onChange(shortcut)
//                isRecording = false
//            }
//        )
//    }
//
//    private func resetToDefault() {
//        debugPrint("🎯 [HotkeyRecorder] Resetting to default")
//        KeyboardShortcuts.setShortcut(defaultShortcut, for: name)
//        currentShortcut = defaultShortcut
//        onChange(defaultShortcut)
//    }
//}

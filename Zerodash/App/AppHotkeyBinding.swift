//
//  AppHotkeyBinding.swift
//  Zerodash
//
//  Created by CA on 30/08/25.



import KeyboardShortcuts

@MainActor
final class AppHotkeyBinding {
    static let shared = AppHotkeyBinding()

    init() {
        KeyboardShortcuts.onKeyUp(for: .toggleDashboard) {
            AppController.shared.toggleDashboard()
        }
    }
}

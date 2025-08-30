//
//  SettingsView.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//


import SwiftUI
import KeyboardShortcuts

struct SettingsView: View {
    var body: some View {
        Form {
            Section("Hotkeys") {
                KeyboardShortcuts.Recorder("Toggle Dashboard:", name: .toggleDashboard)
                Text("Tip: If using Command–Space, remap Spotlight in System Settings.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .frame(width: 420)
    }
}

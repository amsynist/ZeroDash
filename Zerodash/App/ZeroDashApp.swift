import SwiftUI

@main
struct ZeroDashApp: App {
    @State private var hotkeyBinding = AppHotkeyBinding()

    var body: some Scene {
        // Use MenuBarExtra instead of WindowGroup for commands
        MenuBarExtra("ZeroDash", systemImage: "bolt.circle.fill") {
            Button("Toggle Dashboard") {
                AppController.shared.toggleDashboard()
            }
            .keyboardShortcut(" ", modifiers: [.command])
            
            Divider()
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        
        Settings {
            SettingsView()
        }
    }
}

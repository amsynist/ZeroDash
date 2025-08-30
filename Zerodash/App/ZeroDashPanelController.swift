//
//  ZeroDashPanelController.swift
//  Zerodash
//

import AppKit
import SwiftUI

@MainActor
final class ZeroDashPanelController {
    private var panel: ZeroDashPanel?
    private var hosting: NSHostingView<AnyView>?

    private let defaultSize = CGSize(width: 860, height: 620)
    private let nonActivating = true

    func toggle(content: some View,
                size: CGSize? = nil,
                centerOnFirstShow: Bool = true,
                activateApp: Bool = false) {
        if let p = panel, p.isVisible {
            debugPrint("Panel", "Hiding panel")
            hide()
        } else {
            debugPrint("Panel", "Showing panel")
            show(content: content,
                 size: size,
                 centerOnFirstShow: centerOnFirstShow,
                 activateApp: activateApp)
        }
    }

    func show(content: some View,
              size: CGSize? = nil,
              centerOnFirstShow: Bool = true,
              activateApp: Bool = false) {
        let size = size ?? defaultSize

        if panel == nil {
            debugPrint("Panel", "Creating new panel with size: \(size)")
            let p = ZeroDashPanel(size: size, nonActivating: nonActivating)

            let hv = NSHostingView(rootView: AnyView(content))
            hv.translatesAutoresizingMaskIntoConstraints = false
            hv.wantsLayer = true
            hv.layer?.backgroundColor = NSColor.clear.cgColor   // ✅ transparent hosting view

            p.contentView = hv
            NSLayoutConstraint.activate([
                hv.widthAnchor.constraint(equalToConstant: size.width),
                hv.heightAnchor.constraint(equalToConstant: size.height)
            ])

            panel = p
            hosting = hv
        } else {
            debugPrint("Panel", "Updating existing panel content")
            hosting?.rootView = AnyView(content)
        }

        guard let p = panel else { return }

        // Always reposition to current mouse screen before showing
        repositionToMouseScreen(panel: p)

        p.orderFrontRegardless()
        p.makeKeyAndOrderFront(nil)

        if activateApp {
            NSApp.activate(ignoringOtherApps: false)
        }

        debugPrint("Panel", "Panel displayed and focused")
    }

    func hide() {
        panel?.orderOut(nil)
        debugPrint("Panel", "Panel hidden")
    }

    // MARK: - Smart Positioning (always runs)
    private func repositionToMouseScreen(panel: ZeroDashPanel) {
        let mouseLocation = NSEvent.mouseLocation
        debugPrint("Panel", "Current mouse location: \(mouseLocation)")

        // Find screen containing the mouse cursor
        let targetScreen = NSScreen.screens.first { screen in
            NSMouseInRect(mouseLocation, screen.frame, false)
        } ?? NSScreen.main ?? NSScreen.screens.first

        guard let screen = targetScreen else {
            debugPrint("Panel", "⚠️ No screen found, keeping current position")
            return
        }

        let screenName = screen.localizedName
        debugPrint("Panel", "Target screen: \(screenName)")
        debugPrint("Panel", "Screen frame: \(screen.frame)")
        debugPrint("Panel", "Screen visible frame: \(screen.visibleFrame)")

        // Calculate center position on the target screen's visible area
        let screenFrame = screen.visibleFrame // Excludes menu bar and dock
        let panelSize = panel.frame.size

        let x = screenFrame.origin.x + (screenFrame.size.width - panelSize.width) / 2
        let y = screenFrame.origin.y + (screenFrame.size.height - panelSize.height) / 2

        let centerPoint = NSPoint(x: x, y: y)

        // Get old position for comparison
        let oldPosition = panel.frame.origin
        panel.setFrameOrigin(centerPoint)

        debugPrint("Panel", "Repositioned from \(oldPosition) → \(centerPoint) on screen: \(screenName)")
    }
}

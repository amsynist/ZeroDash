//
//  ZeroDashPanel.swift
//  Zerodash
//

import AppKit

final class ZeroDashPanel: NSPanel {
    init(size: CGSize, nonActivating: Bool = true) {
        let rect = NSRect(x: 0, y: 0, width: size.width, height: size.height)

        var mask: NSWindow.StyleMask = [.borderless]
        if nonActivating {
            mask.insert(.nonactivatingPanel)
        }

        super.init(
            contentRect: rect,
            styleMask: mask,
            backing: .buffered,
            defer: false
        )

        // Transparent backing — all corner masking handled in SwiftUI
        isOpaque = false
        backgroundColor = .clear
        hasShadow = false

        // Always on top but non-blocking
        level = .floating
        collectionBehavior = [
            .canJoinAllSpaces, .ignoresCycle, .fullScreenAuxiliary,
        ]
    }

    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }
}

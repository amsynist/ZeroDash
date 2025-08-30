//
//  DashboardChrome.swift
//  Zerodash
//

import SwiftUI

struct DashboardRoot: View {
    var body: some View {
        DashboardChrome(content: DashboardView())
    }
}


struct DashboardChrome<Content: View>: View {
    let content: Content
    private let corner: CGFloat = 18

    var body: some View {
        ZStack {
            // HUD glass background
            RoundedRectangle(cornerRadius: corner, style: .continuous)
                .fill(Color.black.opacity(0.45))       // tinted dark
                .background(.ultraThinMaterial)        // native blur layer
                .overlay(
                    // Very subtle gradient tint (blue → purple glow feel)
                    LinearGradient(
                        colors: [
                            Color.blue.opacity(0.08),
                            Color.purple.opacity(0.08)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: corner, style: .continuous))
                )
                .shadow(color: .black.opacity(0.5), radius: 24, x: 0, y: 14)

                // Neon-like stroke around edges
                .overlay(
                    RoundedRectangle(cornerRadius: corner, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.08),
                                    Color.cyan.opacity(0.25)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.1
                        )
                )

                .overlay(content.padding(20))
                .clipShape(RoundedRectangle(cornerRadius: corner, style: .continuous))
                .padding(8)
        }
        .compositingGroup()
        .preferredColorScheme(.dark)
    }
}




#Preview("Dashboard") {
    DashboardRoot()
        .frame(width: 800, height: 500)
        .preferredColorScheme(.dark)
}

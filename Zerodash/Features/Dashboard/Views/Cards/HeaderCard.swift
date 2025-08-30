import SwiftUI

// MARK: - HeaderCard
struct HeaderCard: View {
    @State private var currentTime = Date()
    @State private var isHovering = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
            // Left side - Power + Settings + User
            HStack(spacing: 18) {
                // Power button
                CircleButton(systemName: "power", color: .red) {
                    AppController.shared.hideDashboard()
                    debugPrint(
                        "HeaderCard",
                        "Power button pressed - hiding dashboard"
                    )
                }

                // Settings
                CircleButton(
                    systemName: "gearshape.fill",
                    color: .gray.opacity(0.3)
                ) {
                    debugPrint("HeaderCard", "Settings button pressed")
                }

                // User info
                VStack(alignment: .leading, spacing: 2) {
                    Text("<CodeZero/>")
                        .foregroundColor(.white)
                        .font(
                            .system(
                                size: 14,
                                weight: .semibold,
                                design: .monospaced
                            )
                        )

                    HStack(spacing: 4) {
                        Circle()
                            .fill(.green)
                            .frame(width: 4, height: 4)
                        Text("active")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 10, weight: .medium))
                    }
                }
            }

            // Center - Time in capsule
            Text(currentTime, formatter: timeFormatter)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.08))
                        .overlay(
                            Capsule().stroke(
                                Color.white.opacity(0.15),
                                lineWidth: 1
                            )
                        )
                        .shadow(
                            color: .blue.opacity(0.4),
                            radius: 8,
                            x: 0,
                            y: 0
                        )
                )
            DashItButton(action: {
                debugPrint("⚡️ DashIt triggered — main dashboard action")
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 16, weight: .bold))
                    Text("Dash")
                }
            }

        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.clear)  // <- no separate bar
        .onReceive(timer) { _ in
            currentTime = Date()
        }.frame(height: 64)
    }

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        return formatter
    }
}

// MARK: - DashItButton (Crisp multi-stroke pulse + marching edge)
struct DashItButton<Content: View>: View {
    private let corner: CGFloat = 18
    let action: () -> Void
    let content: Content

    @State private var isHovering = false
    @State private var pulsePhase: CGFloat = 0  // 0→1 drives ripple
    @State private var dashPhase: CGFloat = 0  // marching border

    init(
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.action = action
        self.content = content()
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                // Base fill
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.blue, Color.cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                // Crisp marching outline (no blur)
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(
                        AngularGradient(
                            colors: [.cyan, .blue, .cyan],
                            center: .center
                        ),
                        style: StrokeStyle(
                            lineWidth: isHovering ? 2.5 : 2,
                            lineCap: .round,
                            lineJoin: .round,
                            dash: [10, 8],
                            dashPhase: dashPhase
                        )
                    )
                    .opacity(isHovering ? 1 : 0.0)
                // Label
                content
                    .foregroundColor(.white)
                    .font(
                        .system(size: 18, weight: .semibold, design: .rounded)
                    )
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
            }
            .contentShape(RoundedRectangle(cornerRadius: corner))
            .scaleEffect(isHovering ? 1.03 : 1.0)
            .animation(
                .spring(response: 0.28, dampingFraction: 0.9),
                value: isHovering
            )
        }
        .buttonStyle(.plain)
        .onHover { hover in
            isHovering = hover
            if hover {
                // start loops
                pulsePhase = 0
                dashPhase = 0
                withAnimation(
                    .linear(duration: 1.4).repeatForever(autoreverses: false)
                ) {
                    pulsePhase = 1
                }
                withAnimation(
                    .linear(duration: 1.0).repeatForever(autoreverses: false)
                ) {
                    dashPhase = 80
                }
            } else {
                // stop + reset
                withAnimation(.easeOut(duration: 0.2)) {
                    pulsePhase = 0
                    dashPhase = 0
                }
            }
        }
    }
}

// MARK: - Small Reusable CircleButton
struct CircleButton: View {
    let systemName: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 32, height: 32)
                    .shadow(color: color.opacity(0.4), radius: 6, x: 0, y: 2)

                Image(systemName: systemName)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .semibold))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HeaderCard()
        .background(Color.black)
        .preferredColorScheme(.dark)
}

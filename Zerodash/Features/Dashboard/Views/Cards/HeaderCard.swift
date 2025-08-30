import SwiftUI

struct HeaderCard: View {
    @State private var currentTime = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack(spacing: 0) {
            // Left Control Panel - Let it size naturally
            ControlPanel()
            
            Spacer(minLength: 20)

            // Center time display - Fixed minimum width
            ClockView(currentTime: currentTime)
                .frame(minWidth: 140)
            
            Spacer(minLength: 20)

            // Right primary action - Let it size naturally
            DashButton {
                debugPrint("⚡️ DashIt triggered — main dashboard action")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.clear)
        .onReceive(timer) { _ in
            currentTime = Date()
        }
        .frame(height: 64)
    }
}



// MARK: - Optimized Control Panel
struct ControlPanel: View {
    var body: some View {
        HStack(spacing: 14) {  // Consistent spacing
            // Power button
            HeaderButton(systemName: "power", color: .red) {
                AppController.shared.hideDashboard()
                debugPrint(
                    "HeaderCard",
                    "Power button pressed - hiding dashboard"
                )
            }

            // Settings button
            HeaderButton(
                systemName: "gearshape.fill",
                color: .gray.opacity(0.4)
            ) {
                debugPrint("HeaderCard", "Settings button pressed")
            }

            // User profile - Compact layout
            UserProfile(name: "<CodeZero/>", status: "active")
        }
    }
}

// MARK: - Compact Header Button
struct HeaderButton: View {
    let systemName: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color.gradient)
                    .frame(width: 28, height: 28)  // Slightly smaller
                    .shadow(color: color.opacity(0.3), radius: 4, x: 0, y: 2)

                Image(systemName: systemName)
                    .foregroundColor(.white)
                    .font(.system(size: 11, weight: .semibold))
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Compact User Profile
struct UserProfile: View {
    let name: String
    let status: String

    var body: some View {
        HStack(spacing: 6) {  // Horizontal layout for compactness
            VStack(alignment: .leading, spacing: 1) {
                Text(name)
                    .foregroundColor(.white)
                    .font(
                        .system(
                            size: 12,
                            weight: .semibold,
                            design: .monospaced
                        )
                    )

                HStack(spacing: 3) {
                    StatusIndicator(isActive: status == "active")
                    Text(status)
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 9, weight: .medium))
                }
            }
        }
    }
}

// MARK: - Status Indicator
struct StatusIndicator: View {
    let isActive: Bool

    var body: some View {
        Circle()
            .fill(isActive ? .green : .orange)
            .frame(width: 4, height: 4)
    }
}

// MARK: - Centered Clock Display
struct ClockView: View {
    let currentTime: Date

    var body: some View {
        Text(currentTime, formatter: timeFormatter)
            .foregroundColor(.white)
            .font(.system(size: 15, weight: .semibold, design: .monospaced))
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
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
                        color: .blue.opacity(0.3),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
            )
    }

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        return formatter
    }
}

// MARK: - Optimized Dash Button
struct DashButton: View {
    private let corner: CGFloat = 16  // Slightly smaller radius
    let action: () -> Void

    @State private var isHovering = false
    @State private var pulsePhase: CGFloat = 0
    @State private var dashPhase: CGFloat = 0

    var body: some View {
        Button(action: action) {
            ZStack {
                // Base fill with pulse effect
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.blue, Color.cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .scaleEffect(1 + 0.01 * pulsePhase)  // Subtle pulse

                // Animated border
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(
                        AngularGradient(
                            colors: [.cyan, .blue, .cyan],
                            center: .center
                        ),
                        style: StrokeStyle(
                            lineWidth: isHovering ? 2 : 1.5,
                            lineCap: .round,
                            lineJoin: .round,
                            dash: [8, 6],
                            dashPhase: dashPhase
                        )
                    )
                    .opacity(isHovering ? 1 : 0)

                // Button content - Optimized spacing
                HStack(spacing: 6) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 12, weight: .bold))
                    Text("Dash")
                        .font(.system(size: 13, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
            }
            .contentShape(RoundedRectangle(cornerRadius: corner))
            .scaleEffect(isHovering ? 1.02 : 1.0)
            .animation(
                .spring(response: 0.25, dampingFraction: 0.8),
                value: isHovering
            )
        }
        .buttonStyle(.plain)
        .onHover { hover in
            isHovering = hover
            if hover {
                pulsePhase = 0
                dashPhase = 0
                withAnimation(
                    .linear(duration: 1.2).repeatForever(autoreverses: false)
                ) {
                    pulsePhase = 1
                }
                withAnimation(
                    .linear(duration: 0.8).repeatForever(autoreverses: false)
                ) {
                    dashPhase = 60
                }
            } else {
                withAnimation(.easeOut(duration: 0.2)) {
                    pulsePhase = 0
                    dashPhase = 0
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HeaderCard()
        .frame(
            width: AppConstants.Layout.dashboardWidth

        )
        .preferredColorScheme(.dark)
        .padding()
        .background(.black)
}

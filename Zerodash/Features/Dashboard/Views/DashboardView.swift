import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            GeometryReader { geo in
                HStack(spacing: 0) {
                    HeaderCard()

                }
            }
        }
        .layoutPriority(1)
        .padding(12)
        .shadow(color: .black.opacity(0.35), radius: 20, x: 0, y: 8)
    }
}

#Preview {
    DashboardView()
        .frame(
            width: AppConstants.Layout.dashboardWidth,
            height: AppConstants.Layout.dashboardHeight
        )
        .background(Color.black)
        .preferredColorScheme(.dark)
}

import SwiftUI
import ServicesSampleData

// MARK: - Status Badge View

struct StatusBadgeView: View {

    // MARK: - Properties

    let status: ServiceStatus

    // MARK: - Body

    var body: some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 3)
                .fill(statusColor.opacity(0.3))
                .frame(width: 14, height: 14)

            Text(status.rawValue)
                .font(.caption2)
                .fontWeight(.light)
                .foregroundColor(statusColor)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 3)
        .background(statusColor.opacity(0.1))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(statusColor.opacity(0.3), lineWidth: 0.5)
        )
    }

    // MARK: - Private Properties

    private var statusColor: Color {
        switch status {
        case .active:
            return .green
        case .scheduled:
            return .blue
        case .completed:
            return Color(.darkGray)
        case .inProgress:
            return .orange
        case .urgent:
            return .red
        }
    }
}

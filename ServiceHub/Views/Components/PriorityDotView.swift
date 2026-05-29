import SwiftUI
import ServicesSampleData

// MARK: - Priority Dot View

struct PriorityDotView: View {

    // MARK: - Properties

    let priority: Priority

    // MARK: - Body

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
    }

    // MARK: - Private Properties

    private var color: Color {
        switch priority {
        case .low:      return .green
        case .medium:   return .yellow
        case .high:     return .blue
        case .critical: return .red
        }
    }
}

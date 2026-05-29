import SwiftUI
import ServicesSampleData

// MARK: - Service Row View

struct ServiceRowView: View {

    // MARK: - Properties

    let service: Service

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleRow
            descriptionRow
            statusDateRow
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
    }

    // MARK: - Private Views

    private var titleRow: some View {
        HStack {
            Text(service.title)
                .font(.body)
                .fontWeight(.semibold)
            Spacer()
            PriorityDotView(priority: service.priority)
        }
    }

    private var descriptionRow: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 8) {
                Image("User")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text(service.customerName)
                    .font(.footnote)
                    .fontWeight(.light)
            }
            HStack(alignment: .top, spacing: 8) {
                Image("Description")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text(service.description)
                    .font(.footnote)
                    .fontWeight(.light)
                    .lineLimit(2)
            }
        }
    }

    private var statusDateRow: some View {
        HStack {
            StatusBadgeView(status: service.status)
            Spacer()
            Text(DateFormatterHelper.format(service.scheduledDate))
                .font(.caption)
                .foregroundColor(Color(.darkGray))
        }
    }
}

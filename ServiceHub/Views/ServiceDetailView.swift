import SwiftUI
import ServicesSampleData

// MARK: - Service Detail View

struct ServiceDetailView: View {

    // MARK: - Properties

    let service: Service

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                MapSectionView()

                titleStatusRow

                ServiceInfoRow(icon: "User", title: "Customer", value: service.customerName)
                ServiceInfoRow(icon: "Description", title: "Description", value: service.description)
                ServiceInfoRow(icon: "Time", title: "Scheduled Time", value: DateFormatterHelper.format(service.scheduledDate))
                ServiceInfoRow(icon: "Location", title: "Location", value: service.location)
                ServiceInfoRow(icon: "Notes", title: "Service Notes", value: service.serviceNotes)
            }
            .padding(.all, 12)
        }
        .navigationTitle("Service Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Private Views

    private var titleStatusRow: some View {
        HStack {
            Text(service.title)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            StatusBadgeView(status: service.status)
        }
    }
}

#Preview {
    ServiceDetailView(service: Service(id: "1", title: "Office Space Revamp", customerName: "XYZ Industries", description: "Transform your office with sleek, contemporary furnishings.", status: .scheduled, priority: .medium, scheduledDate: "Today, 3:00 PM", location: "Chennai", serviceNotes: "Ensure all furniture is removed before the renovation begins. Confirm the layout with the client and finalize color schemes for walls and furnishings."))
}

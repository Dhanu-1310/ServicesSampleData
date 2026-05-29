import SwiftUI
import ServicesSampleData

// MARK: - Service List View

struct ServiceListView: View {

    // MARK: - Properties

    @StateObject private var viewModel = ServicesViewModel()

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.services) { service in
                    ZStack(alignment: .leading) {
                        NavigationLink(value: service) {
                            EmptyView()
                        }
                        .opacity(0)

                        ServiceRowView(service: service)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .refreshable {
                guard viewModel.searchText.isEmpty else { return }
                await viewModel.refreshServices()
            }
            .navigationTitle("Services")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Service.self) { service in
                ServiceDetailView(service: service)
            }
            .overlay {
                emptyStateView
            }
        }
    }

    @ViewBuilder
    private var emptyStateView: some View {
        if viewModel.services.isEmpty && !viewModel.searchText.isEmpty {
            if #available(iOS 17, *) {
                ContentUnavailableView.search(text: viewModel.searchText)
            } else {
                VStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No results for \"\(viewModel.searchText)\"")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

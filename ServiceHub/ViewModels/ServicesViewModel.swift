import Foundation
import Combine
import ServicesSampleData

final class ServicesViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published private(set) var services: [Service] = []

    private var allServices: [Service] = []

    init() {
        loadServices()
        bindSearch()
    }

    @MainActor
    func refreshServices() async {
        try? await Task.sleep(for: .seconds(2))
        loadServices()
    }

    private func loadServices() {
        allServices = SampleData.generateServices(count: 15)
        services = allServices
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { [weak self] query in
                self?.filteredServices(matching: query) ?? []
            }
            .assign(to: &$services)
    }

    private func filteredServices(matching query: String) -> [Service] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return allServices }
        let q = trimmed.lowercased()
        return allServices.filter {
            $0.title.lowercased().contains(q) ||
            $0.customerName.lowercased().contains(q) ||
            $0.description.lowercased().contains(q)
        }
    }
}

import XCTest
import Combine
@testable import ServiceHub
import ServicesSampleData

final class ServicesViewModelTests: XCTestCase {

    private var vm: ServicesViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        vm = ServicesViewModel()
    }

    override func tearDown() {
        cancellables.removeAll()
        vm = nil
        super.tearDown()
    }

    func testInitialLoadHas15Services() {
        XCTAssertEqual(vm.services.count, 15)
    }

    func testSearchTextStartsEmpty() {
        XCTAssertTrue(vm.searchText.isEmpty)
    }

    func testSearchWithGibberishReturnsEmpty() {
        let expectation = XCTestExpectation(description: "Filter returns empty")

        vm.$services
            .dropFirst()
            .first(where: { $0.isEmpty })
            .sink { _ in expectation.fulfill() }
            .store(in: &cancellables)

        vm.searchText = "zzzzz_no_match_99999"
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(vm.services.isEmpty)
    }

    func testSearchByKnownTitleFindsService() {
        guard let title = vm.services.first?.title else {
            XCTFail("No services loaded")
            return
        }

        let expectation = XCTestExpectation(description: "Filter finds service")

        vm.$services
            .dropFirst()
            .first(where: { !$0.isEmpty })
            .sink { services in
                if services.contains(where: { $0.title == title }) {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        vm.searchText = title
        wait(for: [expectation], timeout: 2.0)
    }
}

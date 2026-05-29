import XCTest
@testable import ServiceHub

final class DateFormatterHelperTests: XCTestCase {

    func testInvalidStringReturnsDash() {
        XCTAssertEqual(DateFormatterHelper.format("not-a-date"), "\u{2014}")
    }

    func testEmptyStringReturnsDash() {
        XCTAssertEqual(DateFormatterHelper.format(""), "\u{2014}")
    }

    func testTodayISOReturnsToday() {
        let iso = ISO8601DateFormatter().string(from: Date())
        let result = DateFormatterHelper.format(iso)
        XCTAssertTrue(result.hasPrefix("Today,"), "Expected 'Today,' prefix, got: \(result)")
    }

    func testTomorrowISOReturnsTomorrow() {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let iso = ISO8601DateFormatter().string(from: tomorrow)
        let result = DateFormatterHelper.format(iso)
        XCTAssertTrue(result.hasPrefix("Tomorrow,"), "Expected 'Tomorrow,' prefix, got: \(result)")
    }

    func testYesterdayISOReturnsYesterday() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let iso = ISO8601DateFormatter().string(from: yesterday)
        let result = DateFormatterHelper.format(iso)
        XCTAssertTrue(result.hasPrefix("Yesterday,"), "Expected 'Yesterday,' prefix, got: \(result)")
    }

    func testOlderDateReturnsFullDateFormat() {
        var components = DateComponents()
        components.year = 2025
        components.month = 1
        components.day = 15
        components.hour = 10
        components.minute = 30
        let date = Calendar.current.date(from: components)!
        let iso = ISO8601DateFormatter().string(from: date)
        let result = DateFormatterHelper.format(iso)
        XCTAssertTrue(result.contains("15/01/2025"), "Expected dd/MM/yyyy format, got: \(result)")
    }

    func testResultContainsTimeWithAMOrPM() {
        let iso = ISO8601DateFormatter().string(from: Date())
        let result = DateFormatterHelper.format(iso)
        XCTAssertTrue(
            result.contains("AM") || result.contains("PM"),
            "Expected AM/PM in result, got: \(result)"
        )
    }
}

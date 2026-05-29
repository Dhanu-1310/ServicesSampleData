import Foundation

// MARK: - Date Formatter Helper

struct DateFormatterHelper {

    // MARK: - Cached Formatters

    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }()

    private static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    // MARK: - Public Methods

    static func format(_ isoString: String) -> String {
        guard let date = isoFormatter.date(from: isoString) else {
            return "\u{2014}"
        }

        let timeString = timeFormatter.string(from: date)
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today, \(timeString)"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow, \(timeString)"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday, \(timeString)"
        } else {
            let dateString = fullDateFormatter.string(from: date)
            return "\(dateString), \(timeString)"
        }
    }
}

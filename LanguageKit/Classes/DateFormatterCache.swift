import Foundation

class DateFormatterCache {
    static let shared = DateFormatterCache()

    private var formatters = [CacheKey: DateFormatter]()

    func getFormatter(forFormat format: String) -> DateFormatter {
        let key = CacheKey(format: format, localeIdentifier: Locale.appCurrent.identifier)

        if let formatter = formatters[key] {
            return formatter
        }

        let formatter = DateFormatter()
        formatter.locale = Locale.appCurrent
        formatter.setLocalizedDateFormatFromTemplate(format)

        formatters[key] = formatter

        return formatter
    }

    private struct CacheKey: Hashable {
        let format: String
        let localeIdentifier: String
    }

}

extension DateFormatter {

    public static func cachedFormatter(format: String) -> DateFormatter {
        DateFormatterCache.shared.getFormatter(forFormat: format)
    }

}

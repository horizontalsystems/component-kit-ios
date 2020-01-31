import Foundation

class DateFormatterCache {
    static let shared = DateFormatterCache()

    private var formatters = [CacheKey: DateFormatter]()

    func getFormatter(forFormat format: String) -> DateFormatter {
        let key = CacheKey(format: format, language: LanguageManager.shared.currentLanguage)

        if let formatter = formatters[key] {
            return formatter
        }

        let formatter = DateFormatter()
        formatter.locale = LanguageManager.shared.currentLocale
        formatter.setLocalizedDateFormatFromTemplate(format)

        formatters[key] = formatter

        return formatter
    }

    private struct CacheKey: Hashable {
        let format: String
        let language: String
    }

}

extension DateFormatter {

    public static func cachedFormatter(format: String) -> DateFormatter {
        DateFormatterCache.shared.getFormatter(forFormat: format)
    }

}

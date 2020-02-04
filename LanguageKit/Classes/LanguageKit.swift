import UIKit

class LanguageKit {

    static var bundle: Bundle? {
        Bundle(for: LanguageKit.self).url(forResource: "LanguageKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

extension String {

    var localized: String {
        LanguageManager.shared.localize(string: self, bundle: LanguageKit.bundle)
    }

    func localized(_ arguments: CVarArg...) -> String {
        LanguageManager.shared.localize(string: self, bundle: LanguageKit.bundle, arguments: arguments)
    }

}

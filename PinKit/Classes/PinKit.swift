import LanguageKit

class PinKit {

    static var bundle: Bundle? {
        Bundle(for: PinKit.self).url(forResource: "PinKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

extension String {

    var localized: String {
        LanguageManager.shared.localize(string: self, bundle: PinKit.bundle)
    }

    func localized(_ arguments: CVarArg...) -> String {
        LanguageManager.shared.localize(string: self, bundle: PinKit.bundle, arguments: arguments)
    }

}

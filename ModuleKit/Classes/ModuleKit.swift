import LanguageKit

class ModuleKit {

    static var bundle: Bundle? {
        Bundle(for: ModuleKit.self).url(forResource: "ModuleKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

extension String {

    var localized: String {
        LanguageManager.shared.localize(string: self, bundle: ModuleKit.bundle)
    }

    func localized(_ arguments: CVarArg...) -> String {
        LanguageManager.shared.localize(string: self, bundle: ModuleKit.bundle, arguments: arguments)
    }

}

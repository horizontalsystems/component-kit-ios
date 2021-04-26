import LanguageKit

public class ComponentKit {

    static var bundle: Bundle? {
        Bundle(for: ComponentKit.self).url(forResource: "ComponentKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    public static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

extension String {

    var localized: String {
        LanguageManager.shared.localize(string: self, bundle: ComponentKit.bundle)
    }

    func localized(_ arguments: CVarArg...) -> String {
        LanguageManager.shared.localize(string: self, bundle: ComponentKit.bundle, arguments: arguments)
    }

}

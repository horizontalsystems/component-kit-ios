import UIKit

class LanguageKitBundle {
    static let shared = LanguageKitBundle()

    private lazy var bundle: Bundle? = {
        guard let bundleUrl = Bundle(for: LanguageKitBundle.self).url(forResource: "LanguageKit", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: bundleUrl)
    }()

    func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

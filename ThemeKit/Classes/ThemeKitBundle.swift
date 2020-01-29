import UIKit

class ThemeKitBundle {
    static let shared = ThemeKitBundle()

    private lazy var bundle: Bundle? = {
        guard let subBundleUrl = Bundle(for: ThemeKitBundle.self).url(forResource: "ThemeKit", withExtension: "bundle"),
            let subBundle = Bundle(url: subBundleUrl) else {
            return nil
        }
        return subBundle
    }()

    func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

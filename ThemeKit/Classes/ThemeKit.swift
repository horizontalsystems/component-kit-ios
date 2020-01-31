import UIKit

class ThemeKit {

    static var bundle: Bundle? {
        Bundle.main.url(forResource: "ThemeKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

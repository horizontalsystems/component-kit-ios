import UIKit

class CurrencyKit {

    static var bundle: Bundle? {
        Bundle(for: CurrencyKit.self).url(forResource: "CurrencyKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

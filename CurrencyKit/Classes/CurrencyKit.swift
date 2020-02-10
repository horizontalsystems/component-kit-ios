import UIKit
import LanguageKit
import RxSwift

class CurrencyKit {

    static var bundle: Bundle? {
        Bundle(for: CurrencyKit.self).url(forResource: "CurrencyKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

extension String {

    var localized: String {
        LanguageManager.shared.localize(string: self, bundle: CurrencyKit.bundle)
    }

    func localized(_ arguments: CVarArg...) -> String {
        LanguageManager.shared.localize(string: self, bundle: CurrencyKit.bundle, arguments: arguments)
    }

}

public protocol ICurrencyKit {
    var baseCurrency: Currency { get set }
    var currencies: [Currency] { get }
    var baseCurrencyUpdatedObservable: Observable<Currency> { get }
    var baseCurrencySettingsModule: UIViewController { get }
}

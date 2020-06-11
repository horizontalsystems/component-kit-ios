import UIKit
import StorageKit
import RxSwift

public class Kit {
    private static let supportedCurrencies = [
        Currency(code: "USD", symbol: "\u{0024}", decimal: 2),
        Currency(code: "EUR", symbol: "\u{20AC}", decimal: 2),
        Currency(code: "GBP", symbol: "\u{00A3}", decimal: 2),
        Currency(code: "JPY", symbol: "\u{00A5}", decimal: 2)
    ]

    private let currencyManager: CurrencyManager

    public init(localStorage: ILocalStorage, currencyCodes: [String] = []) {
        var currencies = currencyCodes.compactMap { code in
            Kit.supportedCurrencies.first { $0.code == code }
        }

        if currencies.isEmpty {
            currencies = Kit.supportedCurrencies
        }

        currencyManager = CurrencyManager(currencies: currencies, localStorage: localStorage)
    }

}

extension Kit: ICurrencyKit {

    public var baseCurrency: Currency {
        get {
            currencyManager.baseCurrency
        }
        set {
            currencyManager.baseCurrency = newValue
        }
    }

    public var currencies: [Currency] {
        currencyManager.currencies
    }

    public var baseCurrencyUpdatedObservable: Observable<Currency> {
        currencyManager.baseCurrencyUpdatedObservable
    }

    public var baseCurrencySettingsModule: UIViewController {
        BaseCurrencySettingsRouter.module(currencyManager: currencyManager)
    }

}

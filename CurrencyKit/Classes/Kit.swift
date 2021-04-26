import UIKit
import StorageKit
import RxSwift

public class Kit {
    private static let supportedCurrencies = [
        Currency(code: "AUD", symbol: "A$",  decimal: 2),
        Currency(code: "BRL", symbol: "R$",  decimal: 2),
        Currency(code: "CAD", symbol: "C$",  decimal: 2),
        Currency(code: "CHF", symbol: "₣",   decimal: 2),
        Currency(code: "CNY", symbol: "¥",   decimal: 2),
        Currency(code: "EUR", symbol: "€",   decimal: 2),
        Currency(code: "GBP", symbol: "£",   decimal: 2),
        Currency(code: "HKD", symbol: "HK$", decimal: 2),
        Currency(code: "ILS", symbol: "₪",   decimal: 2),
        Currency(code: "JPY", symbol: "¥",   decimal: 2),
        Currency(code: "RUB", symbol: "₽",   decimal: 2),
        Currency(code: "SGD", symbol: "S$",  decimal: 2),
        Currency(code: "USD", symbol: "$",   decimal: 2),

        Currency(code: "BTC", symbol: "₿",   decimal: 8),
        Currency(code: "ETH", symbol: "Ξ",   decimal: 8),
        Currency(code: "BNB", symbol: "BNB", decimal: 8),
    ]

    private let currencyManager: CurrencyManager

    public init(localStorage: ILocalStorage) {
        currencyManager = CurrencyManager(currencies: Kit.supportedCurrencies, localStorage: localStorage)
    }

}

extension Kit {

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

    public static func currencyIcon(code: String) -> UIImage? {
        CurrencyKit.image(named: code)
    }

}

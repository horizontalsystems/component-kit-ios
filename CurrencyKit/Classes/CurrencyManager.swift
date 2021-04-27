import RxSwift
import StorageKit

public class CurrencyManager {
    private let keyBaseCurrencyCode = "base_currency_code"

    let currencies: [Currency]

    private let localStorage: ILocalStorage
    private let subject = PublishSubject<Currency>()

    init(currencies: [Currency], localStorage: ILocalStorage) {
        self.currencies = currencies
        self.localStorage = localStorage
    }

    var baseCurrency: Currency {
        get {
            if let storedCode: String = localStorage.value(for: keyBaseCurrencyCode), let currency = currencies.first(where: { $0.code == storedCode }) {
                return currency
            }

            return currencies.first(where: { $0.code == "USD" }) ?? currencies[0]
        }
        set {
            localStorage.set(value: newValue.code, for: keyBaseCurrencyCode)
            subject.onNext(newValue)
        }
    }

    var baseCurrencyUpdatedObservable: Observable<Currency> {
        subject.asObservable()
    }

}

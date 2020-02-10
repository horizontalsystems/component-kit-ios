class BaseCurrencySettingsInteractor {
    private let currencyManager: CurrencyManager

    init(currencyManager: CurrencyManager) {
        self.currencyManager = currencyManager
    }

}

extension BaseCurrencySettingsInteractor: IBaseCurrencySettingsInteractor {

    var baseCurrency: Currency {
        get {
            currencyManager.baseCurrency
        }
        set {
            currencyManager.baseCurrency = newValue
        }
    }

    var currencies: [Currency] {
        currencyManager.currencies
    }

}

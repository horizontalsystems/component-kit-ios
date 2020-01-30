class LanguageSettingsInteractor {
    private var languageManager: ILanguageManager

    init(languageManager: ILanguageManager) {
        self.languageManager = languageManager
    }

}

extension LanguageSettingsInteractor: ILanguageSettingsInteractor {

    var currentLanguage: String {
        get {
            languageManager.currentLanguage
        }
        set {
            languageManager.currentLanguage = newValue
        }
    }

    var availableLanguages: [String] {
        languageManager.availableLanguages
    }

    func displayName(language: String) -> String? {
        languageManager.displayName(language: language)
    }

    func nativeDisplayName(language: String) -> String? {
        languageManager.nativeDisplayName(language: language)
    }

}

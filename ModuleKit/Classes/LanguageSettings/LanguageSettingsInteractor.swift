import LanguageKit

class LanguageSettingsInteractor: ILanguageSettingsInteractor {

    var currentLanguage: String {
        get {
            LanguageManager.shared.currentLanguage
        }
        set {
            LanguageManager.shared.currentLanguage = newValue
        }
    }

    var availableLanguages: [String] {
        LanguageManager.availableLanguages
    }

    func displayName(language: String) -> String? {
        LanguageManager.shared.displayName(language: language)
    }

    func nativeDisplayName(language: String) -> String? {
        LanguageManager.nativeDisplayName(language: language)
    }

}

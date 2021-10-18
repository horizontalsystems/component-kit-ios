import RxCocoa

public class ThemeManager {
    private static let defaultLightMode: ThemeMode = .system
    private static let userDefaultsKey = "theme_mode"

    private let changeThemeRelay = PublishRelay<ThemeMode>()

    public static var shared = ThemeManager()

    public var themeMode: ThemeMode {
        didSet {
            UserDefaults.standard.set(themeMode.rawValue, forKey: ThemeManager.userDefaultsKey)
            currentTheme = ThemeManager.theme(mode: themeMode)
            Theme.updateNavigationBarTheme()

            changeThemeRelay.accept(themeMode)
        }
    }

    private(set) var currentTheme: ITheme

    init() {
        var storedThemeMode: ThemeMode?

        //migrate from custom theme to system supported
        if let oldLightMode = UserDefaults.standard.value(forKey: "light_mode") as? Bool {
            storedThemeMode = oldLightMode ? .light : .dark
            UserDefaults.standard.set(nil, forKey: "light_mode")
        } else if let newLightMode = UserDefaults.standard.value(forKey: ThemeManager.userDefaultsKey) as? String {
            storedThemeMode = ThemeMode(rawValue: newLightMode)
        }

        themeMode = storedThemeMode ?? ThemeManager.defaultLightMode
        currentTheme = ThemeManager.theme(mode: themeMode)
    }

    private static func theme(mode: ThemeMode) -> ITheme {
        switch mode {
        case .light: return LightTheme()
        case .dark: return DarkTheme()
        case .system: return SystemTheme()
        }
    }

    public var changeThemeSignal: Signal<ThemeMode> {
        changeThemeRelay.asSignal()
    }

}

public class Theme {

    public static var current: ITheme {
        ThemeManager.shared.currentTheme
    }

    public static func updateNavigationBarTheme() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.backgroundColor = .themeNavigationBarBackground
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.themeOz]
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.themeOz]

        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = standardAppearance
    }

}

public enum ThemeMode: String {
    case light
    case dark
    case system
}

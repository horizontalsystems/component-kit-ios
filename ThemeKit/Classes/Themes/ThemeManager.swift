public class ThemeManager {
    private static let defaultLightMode = false
    private static let userDefaultsKey = "light_mode"

    public static var shared = ThemeManager()

    public var lightMode: Bool {
        didSet {
            UserDefaults.standard.set(lightMode, forKey: ThemeManager.userDefaultsKey)
            currentTheme = ThemeManager.theme(lightMode: lightMode)
            Theme.updateNavigationBarTheme()
        }
    }

    private(set) var currentTheme: ITheme

    init() {
        let storedLightMode = UserDefaults.standard.value(forKey: ThemeManager.userDefaultsKey) as? Bool

        lightMode = storedLightMode ?? ThemeManager.defaultLightMode
        currentTheme = ThemeManager.theme(lightMode: lightMode)
    }

    private static func theme(lightMode: Bool) -> ITheme {
        lightMode ? LightTheme() : DarkTheme()
    }

}

public class Theme {

    static var current: ITheme {
        ThemeManager.shared.currentTheme
    }

    public static func updateNavigationBarTheme() {
        UIApplication.shared.keyWindow?.backgroundColor = .themeTyler

        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = .themeNavigationBarBackground
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.themeOz]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.themeOz]

            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        }
    }

}

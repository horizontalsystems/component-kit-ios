import UIExtensions

extension UIColor {
    public static let themeYellowD = UIColor(hex: 0xffa800)
    public static let themeYellowL = UIColor(hex: 0xff8a00)
    public static let themeGreenD = UIColor(hex: 0x05c46b)
    public static let themeGreenL = UIColor(hex: 0x04ad5f)
    public static let themeRedD = UIColor(hex: 0xff4820)
    public static let themeRedL = UIColor(hex: 0xed402e)
    public static let themeBlack = UIColor(hex: 0x000000)
    public static let themeIssykBlue = UIColor(hex: 0x3372FF)
    public static let themeGray = UIColor(hex: 0x808085)
    public static let themeLightGray = UIColor(hex: 0xc8c7cc)
    public static let themeWhite = UIColor(hex: 0xffffff)
    public static let themeSteelDark = UIColor(hex: 0x252933)
    public static let themeSteelLight = UIColor(hex: 0xe1e1e5)
    public static let themeDark = UIColor(hex: 0x13151a)
    public static let themeDark96 = UIColor(hex: 0x13151a, alpha: 0.96)
    public static let themeDarker = UIColor(hex: 0x0f1014)
    public static let themeLight = UIColor(hex: 0xf0f0f0)
    public static let themeLight96 = UIColor(hex: 0xf0f0f0, alpha: 0.96)
    public static let themeBlack50 = UIColor(hex: 0x000000, alpha: 0.5)
    public static let themeWhite50 = UIColor(hex: 0xffffff, alpha: 0.5)
    public static let themeSteel10 = UIColor(hex: 0x73798c, alpha: 0.1)
    public static let themeSteel20 = UIColor(hex: 0x73798c, alpha: 0.2)
    public static let themeGray50 = UIColor(hex: 0x808085, alpha: 0.5)
    public static let themeYellow50 = UIColor(hex: 0xffa800, alpha: 0.5)
    public static let themeYellow20 = UIColor(hex: 0xffa800, alpha: 0.2)
    public static let themeGreen50 = UIColor(hex: 0x05c46b, alpha: 0.5)
    public static let themeRed50 = UIColor(hex: 0xff4820, alpha: 0.5)
    public static let themeLawrencePressedD = UIColor(hex: 0x353842)
    public static let themeLawrencePressedL = UIColor(hex: 0xe3e4e8)
    public static let themeStronbuy = UIColor(hex: 0x1a60ff)
    public static let themeSteelDark10 = UIColor(hex: 0x1c1f27)
    public static let themeSteelLight10 = UIColor(hex: 0xd6d7dd)
}

extension UIColor {
    public static var themeJacob: UIColor { color(dark: .themeYellowD, light: .themeYellowL) }
    public static var themeRemus: UIColor { color(dark: .themeGreenD, light: .themeGreenL) }
    public static var themeLucian: UIColor { color(dark: .themeRedD, light: .themeRedL) }
    public static var themeOz: UIColor { color(dark: .themeLight, light: .themeDark) }
    public static var themeLeah: UIColor { color(dark: .themeSteelLight, light: .themeSteelDark) }
    public static var themeJeremy: UIColor { color(dark: .themeSteel20, light: .themeSteelLight) }
    public static var themeElena: UIColor { color(dark: .themeSteel20, light: .themeLightGray) }
    public static var themeLawrence: UIColor { color(dark: .themeSteelDark, light: .themeWhite) }
    public static var themeLawrencePressed: UIColor { color(dark: .themeLawrencePressedD, light: .themeLawrencePressedL) }
    public static var themeClaude: UIColor { color(dark: .themeDark, light: .themeWhite) }
    public static var themeAndy: UIColor { color(dark: .themeBlack50, light: .themeSteel20) }
    public static var themeTyler: UIColor { color(dark: .themeDark, light: .themeLight) }
    public static var themeTyler96: UIColor { color(dark: .themeDark96, light: .themeLight96) }
    public static var themeNina: UIColor { color(dark: .themeWhite50, light: .themeBlack50) }
    public static var themeHelsing: UIColor { color(dark: .themeDark, light: .themeSteelLight) }
    public static var themeCassandra: UIColor { color(dark: .themeDark, light: .themeLightGray) }
    public static var themeRaina: UIColor { color(dark: .themeSteel10, light: .themeWhite50) }
    public static var themeBran: UIColor { color(dark: .themeLightGray, light: .themeDark) }
    public static var themeBlake: UIColor { color(dark: .themeSteelDark10, light: .themeSteelLight10) }

    private static func color(dark: UIColor, light: UIColor) -> UIColor {
        UIColor { traits in
            traits.userInterfaceStyle == .dark ? dark : light
        }
    }

}

extension UIColor {
    public static var themeBackgroundFromGradient: UIColor { .themeTyler }
    public static var themeBackgroundToGradient: UIColor { .themeHelsing }

    public static var themeInputFieldTintColor: UIColor { .themeJacob }
    public static var themeNavigationBarBackground: UIColor { UIColor.themeTyler96 }
}

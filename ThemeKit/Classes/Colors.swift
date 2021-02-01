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
    public static let themeSteelLight = UIColor(hex: 0xefeff4)
    public static let themeDark = UIColor(hex: 0x13151a)
    public static let themeDarker = UIColor(hex: 0x0f1014)
    public static let themeLight = UIColor(hex: 0xf5f5f5)
    public static let themeBlack50 = UIColor(hex: 0x000000, alpha: 0.5)
    public static let themeWhite50 = UIColor(hex: 0xffffff, alpha: 0.5)
    public static let themeSteel10 = UIColor(hex: 0x73798c, alpha: 0.1)
    public static let themeSteel20 = UIColor(hex: 0x73798c, alpha: 0.2)
    public static let themeGray50 = UIColor(hex: 0x808085, alpha: 0.5)
    public static let themeYellow50 = UIColor(hex: 0xffa800, alpha: 0.5)
    public static let themeGreen50 = UIColor(hex: 0x05c46b, alpha: 0.5)
    public static let themeRed50 = UIColor(hex: 0xff4820, alpha: 0.5)
    public static let themeLawrencePressedD = UIColor(hex: 0x353842)
    public static let themeLawrencePressedL = UIColor(hex: 0xe3e4e8)
    public static let themeStronbuy = UIColor(hex: 0x1a60ff)
}

extension UIColor {
    public static var themeJacob: UIColor { Theme.current.colorJacob }
    public static var themeRemus: UIColor { Theme.current.colorRemus }
    public static var themeLucian: UIColor { Theme.current.colorLucian }
    public static var themeOz: UIColor { Theme.current.colorOz }
    public static var themeLeah: UIColor { Theme.current.colorLeah }
    public static var themeJeremy: UIColor { Theme.current.colorJeremy }
    public static var themeElena: UIColor { Theme.current.colorElena }
    public static var themeLawrence: UIColor { Theme.current.colorLawrence }
    public static var themeLawrencePressed: UIColor { Theme.current.colorLawrencePressed }
    public static var themeClaude: UIColor { Theme.current.colorClaude }
    public static var themeAndy: UIColor { Theme.current.colorAndy }
    public static var themeTyler: UIColor { Theme.current.colorTyler }
    public static var themeNina: UIColor { Theme.current.colorNina }
    public static var themeHelsing: UIColor { Theme.current.colorHelsing }
    public static var themeCassandra: UIColor { Theme.current.colorCassandra }
    public static var themeRaina: UIColor { Theme.current.colorRaina }
    public static var themeBran: UIColor { Theme.current.colorBran }
}

extension UIColor {
    public static var themeBackgroundFromGradient: UIColor { .themeTyler }
    public static var themeBackgroundToGradient: UIColor { .themeHelsing }

    public static var themeInputFieldTintColor: UIColor { .themeJacob }
    public static var themeNavigationBarBackground: UIColor { UIColor.themeTyler.withAlphaComponent(0.96) }
}

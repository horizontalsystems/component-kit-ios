import UIKit

class LightTheme: ITheme {
    let actionSheetBlurStyle: UIBlurEffect.Style = .dark
    let hudBlurStyle: UIBlurEffect.Style = .extraLight
    let keyboardAppearance: UIKeyboardAppearance = .default
    let navigationBarStyle: UIBarStyle = .default
    var statusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        }
        return .default
    }

    let colorJacob: UIColor = .themeYellowL
    let colorRemus: UIColor = .themeGreenL
    let colorLucian: UIColor = .themeRedL
    let colorOz: UIColor = .themeDark
    let colorLeah: UIColor = .themeSteelDark
    let colorJeremy: UIColor = .themeSteelLight
    let colorElena: UIColor = .themeLightGray
    let colorLawrence: UIColor = .themeWhite
    let colorLawrencePressed: UIColor = .themeLawrencePressedL
    let colorClaude: UIColor = .themeWhite
    let colorAndy: UIColor = .themeSteel20
    let colorTyler: UIColor = .themeLight
    let colorNina: UIColor = .themeBlack50
    let colorHelsing: UIColor = .themeSteelLight
    var colorCassandra: UIColor = .themeLightGray

    let alphaSecondaryButtonGradient: CGFloat = 1
}

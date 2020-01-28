import UIKit

extension UIBlurEffect.Style {
    public static var themeHud: UIBlurEffect.Style { Theme.current.hudBlurStyle }
}

extension UIBarStyle {
    public static var themeNavigation: UIBarStyle { Theme.current.navigationBarStyle }
}

extension UIStatusBarStyle {
    public static var themeDefault: UIStatusBarStyle { Theme.current.statusBarStyle }
}

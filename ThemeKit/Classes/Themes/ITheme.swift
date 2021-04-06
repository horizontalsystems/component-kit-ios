import UIKit

protocol ITheme {
    var hudBlurStyle: UIBlurEffect.Style { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    var statusBarStyle: UIStatusBarStyle { get }

    var alphaSecondaryButtonGradient: CGFloat { get }
}

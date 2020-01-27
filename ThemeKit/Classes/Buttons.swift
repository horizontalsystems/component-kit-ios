import UIKit

extension UIButton {

    public static var appYellow: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .headline2
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.themeGray50, for: .disabled)
        button.setBackgroundColor(color: .themeJacob, gradient: (colors: [UIColor(white: 1, alpha: 0.4), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .themeJacob, forState: .highlighted)
        button.setBackgroundColor(color: .themeSteel20, forState: .disabled)
        button.cornerRadius = 8

        return button
    }

    public static var appGreen: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .headline2
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.themeGray50, for: .disabled)
        button.setBackgroundColor(color: .themeRemus, gradient: (colors: [UIColor(white: 1, alpha: 0.4), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .themeRemus, forState: .highlighted)
        button.setBackgroundColor(color: .themeSteel20, forState: .disabled)
        button.cornerRadius = 8

        return button
    }

    public static var appRed: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .headline2
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.themeGray50, for: .disabled)
        button.setBackgroundColor(color: .themeLucian, gradient: (colors: [UIColor(white: 1, alpha: 0.4), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .themeLucian, forState: .highlighted)
        button.setBackgroundColor(color: .themeSteel20, forState: .disabled)
        button.cornerRadius = 8

        return button
    }

    public static var appGray: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .headline2
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.themeGray50, for: .disabled)
        button.setBackgroundColor(color: .themeLightGray, gradient: (colors: [UIColor(white: 1, alpha: 1), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .themeLightGray, forState: .highlighted)
        button.setBackgroundColor(color: .themeSteel20, forState: .disabled)
        button.cornerRadius = 8

        return button
    }

    public static var appSecondary: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .subhead1
        button.setTitleColor(.themeOz, for: .normal)
        button.setTitleColor(.themeGray50, for: .disabled)
        button.setBackgroundColor(color: .themeElena, gradient: (colors: [UIColor(white: 1, alpha: Theme.current.alphaSecondaryButtonGradient), UIColor(white: 1, alpha: 0)], height: .heightButtonSecondary), forState: .normal)
        button.setBackgroundColor(color: .themeElena, forState: .highlighted)
        button.setBackgroundColor(color: .themeJeremy, forState: .disabled)
        button.cornerRadius = 4
        button.borderColor = .themeSteel20
        button.borderWidth = 1
        button.contentEdgeInsets.left = .margin2x
        button.contentEdgeInsets.right = .margin2x

        return button
    }

    public static var appTertiary: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .headline2
        button.setTitleColor(.themeLeah, for: .normal)
        button.setTitleColor(.themeGray50, for: .highlighted)
        button.setTitleColor(.themeGray50, for: .disabled)
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.contentEdgeInsets.left = .margin2x
        button.contentEdgeInsets.right = .margin2x

        return button
    }

}

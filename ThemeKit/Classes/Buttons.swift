import UIKit
import UIExtensions

public enum ThemeButtonStyle {
    case primaryYellow
    case primaryGreen
    case primaryRed
    case primaryGray
    case primaryTransparent
    case secondaryDefault
    case secondaryTransparent
    case secondaryIcon
}

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

open class ThemeButton: UIButton {
    private var backgroundGradients = [UInt: [UIColor]]()

    public func setBackgroundColor(_ color: UIColor, bottomColor: UIColor? = nil, forState state: UIControl.State) {
        var colors = [color]
        if let gradientBottomColor = bottomColor {
            colors.append(gradientBottomColor)
        }
        backgroundGradients[state.rawValue] = colors
        setNeedsDisplay()
    }

    public func setBackgroundColor(_ color: UIColor, blendColor: UIColor, forState state: UIControl.State) {
        setBackgroundColor(color.blend(with: blendColor).toHSBColor, bottomColor: color.toHSBColor, forState: .normal)
    }

    public init() {
        super.init(frame: .zero)

        self.isOpaque = false
        self.backgroundColor = .clear
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.isOpaque = false
        self.backgroundColor = .clear
    }

    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        guard let colors = backgroundGradients[state.rawValue] else {
            // no colors for background
            return
        }

        // BackgroundColor
        let innerPath = createRoundedRectPath(for: rect, radius: self.layer.cornerRadius)
        context.saveGState()
        context.addPath(innerPath)
        context.clip()

        if colors.count == 1 {      // without gradient
            context.setFillColor(colors[0].cgColor)
            context.fill(rect)
        } else {
            let max = colors.count - 1
            let step = CGFloat(1 / max)
            let locations: [CGFloat] = Array(0...max).map { CGFloat($0) * step }
            drawGradient(context: context, rect: rect, colors: colors.map { $0.cgColor }, locations: locations)
        }
        context.restoreGState()
    }

    @objc private func hesitateUpdate() {
        setNeedsDisplay()
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setNeedsDisplay()
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        setNeedsDisplay()
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setNeedsDisplay()

        perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setNeedsDisplay()

        perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }

}

extension ThemeButton {

    @discardableResult public func apply(style: ThemeButtonStyle) -> Self {

        let applyPrimary = {
            self.cornerRadius = 8
            self.titleLabel?.font = .headline2
            self.titleLabel?.textAlignment = .center

//            self.contentEdgeInsets = UIEdgeInsets(top: 15, left: .margin4x, bottom: 15, right: .margin4x)
        }

        let applySecondary = {
            self.cornerRadius = 4
            self.titleLabel?.font = .subhead1
            self.titleLabel?.textAlignment = .center

            self.contentEdgeInsets = UIEdgeInsets(top: 5.5, left: .margin3x, bottom: 5.5, right: .margin3x)
        }

        let applySecondaryBackground = {
            self.setBackgroundColor(.themeJeremy, blendColor: UIColor(white: 1, alpha: Theme.current.alphaSecondaryButtonGradient), forState: .normal)
            self.setBackgroundColor(.themeJeremy, forState: .highlighted)
            self.setBackgroundColor(.themeJeremy, forState: .disabled)

            self.borderColor = .themeSteel20
            self.borderWidth = 1
        }

        switch style {

        case .primaryYellow:
            applyPrimary()

            setTitleColor(.black, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            setBackgroundColor(.themeJacob, blendColor: UIColor(white: 1, alpha: 0.4), forState: .normal)
            setBackgroundColor(.themeJacob, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryGreen:
            applyPrimary()

            setTitleColor(.black, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            setBackgroundColor(.themeRemus, blendColor: UIColor(white: 1, alpha: 0.4), forState: .normal)
            setBackgroundColor(.themeRemus, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryRed:
            applyPrimary()

            setTitleColor(.white, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            setBackgroundColor(.themeLucian, blendColor: UIColor(white: 1, alpha: 0.4), forState: .normal)
            setBackgroundColor(.themeLucian, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryGray:
            applyPrimary()

            setTitleColor(.black, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            setBackgroundColor(.themeLightGray, blendColor: UIColor(white: 1, alpha: 1), forState: .normal)
            setBackgroundColor(.themeLightGray, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryTransparent:
            applyPrimary()

            setTitleColor(.themeOz, for: .normal)
            setTitleColor(.themeNina, for: .highlighted)
            setTitleColor(.themeSteel20, for: .disabled)

        case .secondaryDefault:
            applySecondary()
            applySecondaryBackground()

            setTitleColor(.themeOz, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

        case .secondaryTransparent:
            applySecondary()

            setTitleColor(.themeOz, for: .normal)
            setTitleColor(.themeNina, for: .highlighted)
            setTitleColor(.themeSteel20, for: .disabled)

        case .secondaryIcon:
            applySecondaryBackground()

            cornerRadius = 4

            // titleLabel should not affect button size, that is why we set smallest font
            titleLabel?.font = .systemFont(ofSize: 1)

            contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            setContentCompressionResistancePriority(.required, for: .horizontal)
            setContentCompressionResistancePriority(.required, for: .vertical)
        }

        return self
    }

    @discardableResult public func apply(secondaryIconImage: UIImage?) -> Self {
        setImage(secondaryIconImage?.tinted(with: .themeLeah), for: .normal)
        setImage(secondaryIconImage?.tinted(with: .themeGray50), for: .disabled)

        return self
    }

}

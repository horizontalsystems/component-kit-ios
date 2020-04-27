import UIKit
import UIExtensions

public enum ThemeButtonStyle { case yellow, green, red, gray, secondary, tertiary }

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

        var topColor: UIColor = .clear
        var bottomColor: UIColor?

        let applyDefault = {    // default setup fields for red, green, yellow and gray buttons
            self.cornerRadius = 8

            self.titleLabel?.font = .headline2
            self.setTitleColor(.themeGray50, for: .disabled)

            topColor = UIColor(white: 1, alpha: 0.4)
            self.setBackgroundColor(.themeSteel20, forState: .disabled)
        }

        switch style {
        case .secondary:
            titleLabel?.font = .subhead1
            setTitleColor(.themeOz, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            topColor = UIColor(white: 1, alpha: Theme.current.alphaSecondaryButtonGradient)
            bottomColor = .themeElena

            setBackgroundColor(.themeJeremy, forState: .disabled)

            cornerRadius = 4
            borderColor = .themeSteel20
            borderWidth = 1
            contentEdgeInsets.left = .margin2x
            contentEdgeInsets.right = .margin2x
        case .tertiary:
            titleLabel?.font = .headline2

            setTitleColor(.themeLeah, for: .normal)
            setTitleColor(.themeGray50, for: .highlighted)
            setTitleColor(.themeGray50, for: .disabled)

            contentEdgeInsets.left = .margin2x
            contentEdgeInsets.right = .margin2x
        case .yellow:
            setTitleColor(.black, for: .normal)

            bottomColor = .themeJacob
            applyDefault()
        case .green:
            titleLabel?.font = .headline2
            setTitleColor(.black, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            bottomColor = .themeRemus
            applyDefault()
        case .red:
            setTitleColor(.white, for: .normal)

            bottomColor = .themeLucian
            applyDefault()
        case .gray:
            self.cornerRadius = 8

            self.titleLabel?.font = .headline2
            setTitleColor(.black, for: .normal)

            topColor = UIColor(white: 1, alpha: 1)
            bottomColor = .themeLightGray

            setBackgroundColor(.themeSteel20, forState: .disabled)
        }

        if let bottomColor = bottomColor {
            setBackgroundColor(bottomColor.blend(with: topColor).toHSBColor, bottomColor: bottomColor.toHSBColor, forState: .normal)
            setBackgroundColor(bottomColor, forState: .highlighted)
        } else {
            setBackgroundColor(topColor, forState: .normal)
        }
        return self
    }

}

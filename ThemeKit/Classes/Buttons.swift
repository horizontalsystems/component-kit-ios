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

open class ThemeButton: UIButton {
    private var backgroundGradients = [UInt: [UIColor]]()

    private var style: ThemeButtonStyle?

    public func setBackgroundColor(_ color: UIColor, bottomColor: UIColor? = nil, forState state: UIControl.State) {
        var colors = [color]
        if let gradientBottomColor = bottomColor {
            colors.append(gradientBottomColor)
        }
        backgroundGradients[state.rawValue] = colors
        setNeedsDisplay()
    }

    public func setBackgroundColor(_ color: UIColor, blendColor: UIColor, forState state: UIControl.State) {
        setBackgroundColor(color.blend(with: blendColor).toHSBColor, bottomColor: color.toHSBColor, forState: state)
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

    override open func layoutSubviews() {
        super.layoutSubviews()
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

    override public var isSelected: Bool {
        didSet {
            if let style = style, style == .secondaryTransparent {
                self.borderColor = isSelected ? .themeSteel20 : .clear
                self.borderWidth = isSelected ? 1 : 0
            }
        }
    }

}

extension ThemeButton {

    @discardableResult public func apply(style: ThemeButtonStyle) -> Self {
        self.style = style

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

        let applySecondaryTransparentBackground = {
            self.setBackgroundColor(.clear, forState: .normal)
            self.setBackgroundColor(.themeJeremy, blendColor: UIColor(white: 1, alpha: Theme.current.alphaSecondaryButtonGradient), forState: .selected)
            self.setBackgroundColor(.clear, forState: .highlighted)
            self.setBackgroundColor(.clear, forState: .disabled)
        }

        switch style {

        case .primaryYellow:
            applyPrimary()

            setTitleColor(.black, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            setBackgroundColor(.themeYellowD, blendColor: UIColor(white: 1, alpha: 0.4), forState: .normal)
            setBackgroundColor(.themeYellowD, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryGreen:
            applyPrimary()

            setTitleColor(.black, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            setBackgroundColor(.themeGreenL, blendColor: UIColor(white: 1, alpha: 0.4), forState: .normal)
            setBackgroundColor(.themeGreenL, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryRed:
            applyPrimary()

            setTitleColor(.white, for: .normal)
            setTitleColor(.themeGray50, for: .disabled)

            setBackgroundColor(.themeRedL, blendColor: UIColor(white: 1, alpha: 0.4), forState: .normal)
            setBackgroundColor(.themeRedL, forState: .highlighted)
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
            self.cornerRadius = 14

            applySecondaryTransparentBackground()

            setTitleColor(.themeOz, for: .normal)
            setTitleColor(.themeNina, for: .highlighted)
            setTitleColor(.themeGray50, for: .disabled)
            setTitleColor(.themeOz, for: .selected)

        case .secondaryIcon:
            applySecondaryBackground()

            cornerRadius = 4

            // titleLabel should not affect button size, that is why we set smallest font
            titleLabel?.font = .systemFont(ofSize: 1)

            contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            setContentCompressionResistancePriority(.required, for: .horizontal)
            setContentCompressionResistancePriority(.required, for: .vertical)
            setContentHuggingPriority(.required, for: .horizontal)
            setContentHuggingPriority(.required, for: .vertical)
        }

        return self
    }

    @discardableResult public func apply(secondaryIconImage: UIImage?) -> Self {
        setImage(secondaryIconImage?.tinted(with: .themeLeah), for: .normal)
        setImage(secondaryIconImage?.tinted(with: .themeLeah), for: .highlighted)
        setImage(secondaryIconImage?.tinted(with: .themeGray50), for: .disabled)

        return self
    }

}

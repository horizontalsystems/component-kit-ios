import UIKit
import UIExtensions
import ThemeKit

public enum ThemeButtonStyle {
    case primaryYellow
    case primaryRed
    case primaryGray
    case primaryTransparent
    case primaryIconGray
    case secondaryDefault
    case secondaryDefaultIcon
    case secondaryTransparent
    case secondaryTransparentIcon
    case secondaryIcon
    case tab
}

extension UIControl.State: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }

}

open class ThemeButton: UIButton {
    private var backgroundGradients = [UInt: [UIColor]]()
    private var borderColors: [UInt: UIColor] = [UIControl.State.normal.rawValue: .clear]

    private var imageTintColors = [UIControl.State: UIColor]()

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

    public func setBorderColor(_ color: UIColor, forState state: UIControl.State) {
        borderColors[state.rawValue] = color
    }

    public init() {
        super.init(frame: .zero)

        isOpaque = false
        backgroundColor = .clear
        borderColor = .clear
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        isOpaque = false
        backgroundColor = .clear
        borderColor = .clear
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

    private func updateBorderColor() {
        let value = state.rawValue
        let defaultColor = borderColors[UIControl.State.normal.rawValue]

        for bit in (1...7).reversed() {
            if value >> bit > 0 {
                borderColor = borderColors[1 << bit] ?? defaultColor
                return
            }
        }

        borderColor = defaultColor
    }

    open override var isSelected: Bool {
        didSet {
            updateBorderColor()
        }
    }

    open override var isHighlighted: Bool {
        didSet {
            updateBorderColor()
        }
    }

    open override var isEnabled: Bool {
        didSet {
            updateBorderColor()
        }
    }

    open override func setImage(_ image: UIImage?, for state: State) {
        var isStateSet = false
        imageTintColors.forEach { tintState, color in
            super.setImage(image?.withTintColor(color), for: tintState)
            isStateSet = isStateSet || state == tintState
        }

        if !isStateSet {
            super.setImage(image, for: state)
        }
    }

}

extension ThemeButton {

    @discardableResult public func apply(style: ThemeButtonStyle) -> Self {
        self.style = style
        let applyPrimary = {
            self.cornerRadius = 25
            self.titleLabel?.textAlignment = .center
            self.setTitleColor(.themeClaude, for: .normal)
            self.setTitleColor(.themeGray50, for: .disabled)
        }

        let applySecondary = {
            self.cornerRadius = 14
            self.titleLabel?.textAlignment = .center
        }

        let applySecondaryBackground = {
            self.setBackgroundColor(.themeSteel20, forState: .normal)
            self.setBackgroundColor(.themeSteel20, forState: .highlighted)
            self.setBackgroundColor(.themeSteel20, forState: .disabled)
            self.setBackgroundColor(.themeYellowD, forState: .selected)
        }

        let applySecondaryTitleColor = {
            self.setTitleColor(.themeOz, for: .normal)
            self.setTitleColor(.themeGray, for: .highlighted)
            self.setTitleColor(.themeGray50, for: .disabled)
            self.setTitleColor(.themeDark, for: .selected)
        }

        let applySecondaryTransparentBackground = {
            self.setBackgroundColor(.clear, forState: .normal)
            self.setBackgroundColor(.themeYellowD, forState: .selected)
            self.setBackgroundColor(.clear, forState: .highlighted)
            self.setBackgroundColor(.clear, forState: .disabled)
        }

        let applyPrioritiesRequired = {
            self.setContentCompressionResistancePriority(.required, for: .horizontal)
            self.setContentCompressionResistancePriority(.required, for: .vertical)
            self.setContentHuggingPriority(.required, for: .horizontal)
            self.setContentHuggingPriority(.required, for: .vertical)
        }

        contentEdgeInsets = ThemeButton.contentEdgeInsets(for: style)
        titleLabel?.font = ThemeButton.titleFont(for: style)

        switch style {

        case .primaryYellow:
            applyPrimary()

            setTitleColor(.themeDark, for: .normal)

            setBackgroundColor(.themeYellowD, forState: .normal)
            setBackgroundColor(.themeYellow50, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryRed:
            applyPrimary()

            setBackgroundColor(.themeLucian, forState: .normal)
            setBackgroundColor(.themeRed50, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

        case .primaryGray, .primaryIconGray:
            applyPrimary()

            setBackgroundColor(.themeLeah, forState: .normal)
            setBackgroundColor(.themeNina, forState: .highlighted)
            setBackgroundColor(.themeSteel20, forState: .disabled)

            imageTintColors[.normal] = .themeClaude
            imageTintColors[.highlighted] = .themeClaude
            imageTintColors[.disabled] = .themeGray50

        case .primaryTransparent:
            applyPrimary()

            setTitleColor(.themeOz, for: .normal)
            setTitleColor(.themeNina, for: .highlighted)
            setTitleColor(.themeSteel20, for: .disabled)

        case .secondaryDefault:
            applySecondary()
            applySecondaryBackground()
            applySecondaryTitleColor()
            setTitleColor(.themeClaude, for: .selected)

        case .secondaryTransparent:
            applySecondary()

            applySecondaryTransparentBackground()

            applySecondaryTitleColor()

        case .secondaryTransparentIcon:
            applySecondary()
            applySecondaryTransparentBackground()
            applySecondaryTitleColor()

            semanticContentAttribute = .forceRightToLeft
            applyPrioritiesRequired()

            titleEdgeInsets = UIEdgeInsets(top: 0, left: -.margin4, bottom: 0, right: .margin4)

        case .secondaryDefaultIcon:
            applySecondary()
            applySecondaryBackground()
            applySecondaryTitleColor()

            semanticContentAttribute = .forceRightToLeft
            applyPrioritiesRequired()

            titleEdgeInsets = UIEdgeInsets(top: 0, left: -.margin4, bottom: 0, right: .margin4)
        case .secondaryIcon:
            applySecondary()
            applySecondaryBackground()

            imageTintColors[.normal] = .themeLeah
            imageTintColors[.highlighted] = .themeGray50
            imageTintColors[.disabled] = .themeGray50

            applyPrioritiesRequired()

        case .tab:
            applySecondary()
            applySecondaryTransparentBackground()
            setBackgroundColor(.clear, forState: .selected)

            setTitleColor(.themeGray, for: .normal)
            setTitleColor(.themeOz, for: .selected)
        }

        return self
    }

}

extension ThemeButton {

    private static func contentEdgeInsets(for style: ThemeButtonStyle) -> UIEdgeInsets {
        switch style {
        case .primaryYellow, .primaryRed, .primaryGray, .primaryTransparent: return UIEdgeInsets(top: 15, left: .margin16, bottom: 15, right: .margin16)
        case .primaryIconGray: return UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        case .secondaryDefault, .secondaryTransparent, .tab: return UIEdgeInsets(top: 5.5, left: .margin16, bottom: 5.5, right: .margin16)
        case .secondaryTransparentIcon, .secondaryDefaultIcon: return UIEdgeInsets(top: .margin4, left: .margin16 + .margin4, bottom: .margin4, right: .margin8)
        case .secondaryIcon: return UIEdgeInsets(top: .margin4, left: .margin4, bottom: .margin4, right: .margin4)
        }
    }

    private static func titleFont(for style: ThemeButtonStyle) -> UIFont {
        switch style {
        case .primaryYellow, .primaryRed, .primaryGray, .primaryTransparent, .primaryIconGray: return .headline2
        case .secondaryDefault, .secondaryDefaultIcon, .secondaryTransparent, .secondaryTransparentIcon, .tab: return .subhead1
        case .secondaryIcon: return .systemFont(ofSize: 1) // titleLabel should not affect button size, that is why we set smallest font
        }
    }

    public static func height(style: ThemeButtonStyle? = nil) -> CGFloat {
        let style = style ?? .primaryYellow                 // use as default primary sizes and insets

        let insets = ThemeButton.contentEdgeInsets(for: style)
        let fontSize = round(ThemeButton.titleFont(for: style).lineHeight)

        return fontSize + insets.height
    }

    public static func size(containerWidth: CGFloat, text: String?, icon: UIImage? = nil, style: ThemeButtonStyle) -> CGSize {
        let insets = ThemeButton.contentEdgeInsets(for: style)
        var width: CGFloat = 0, height: CGFloat = 0

        if let text = text {
            let font = ThemeButton.titleFont(for: style)

            let textContainerWidth = containerWidth - insets.left - insets.right
            let textSize = text.size(containerWidth: textContainerWidth, font: font)
            width += textSize.width
            height += textSize.height
        }

        if let icon = icon {
            let iconSize = icon.size
            width += iconSize.width
            height = max(height, iconSize.height)
        }

        return CGSize(
                width: width + insets.width,
                height: height + insets.height
        )
    }

}

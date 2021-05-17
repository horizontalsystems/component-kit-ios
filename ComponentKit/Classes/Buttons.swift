import UIKit
import UIExtensions
import ThemeKit

public enum ThemeButtonStyle {
    case primaryYellow
    case primaryGreen
    case primaryRed
    case primaryGray
    case primaryTransparent
    case secondaryDefault
    case secondaryTransparent
    case secondaryTransparentIcon
    case secondaryIcon
    case tertiary
}

extension UIControl.State: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }

}

open class ThemeButton: UIButton {
    private var backgroundGradients = [UInt: [UIColor]]()
    private var borderColors: [UInt: UIColor] = [UIControl.State.normal.rawValue: .clear]

    private var originalButtonImage: UIImage?
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

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let style = style else {
            return
        }

        apply(style: style)
        updateImageTintColor()
    }

    public func setImageTintColor(_ tintColor: UIColor?, for state: UIControl.State) {
        imageTintColors[state] = tintColor

        if let color = tintColor {
            super.setImage(originalButtonImage?.tinted(with: color), for: state)
        }
    }

    public func imageTintColor(for state: UIControl.State) -> UIColor? {
        imageTintColors[state]
    }

    open override func setImage(_ image: UIImage?, for state: State) {
        originalButtonImage = image

        if let tintColor = imageTintColors[state] {
            super.setImage(image?.tinted(with: tintColor), for: state)
        } else {
            super.setImage(image, for: state)
        }
    }

    private func updateImageTintColor() {
        guard let image = imageView?.image else {
            return
        }

        imageTintColors.forEach { state, tintColor in
            super.setImage(image.tinted(with: tintColor), for: state)
        }
    }

}

extension ThemeButton {

    @discardableResult public func apply(style: ThemeButtonStyle) -> Self {
        self.style = style
        let applyPrimary = {
            self.cornerRadius = 8
            self.titleLabel?.textAlignment = .center
        }

        let applySecondary = {
            self.cornerRadius = 4
            self.titleLabel?.textAlignment = .center
        }

        let applySecondaryBackground = {
            self.setBackgroundColor(.themeJeremy, blendColor: UIColor(white: 1, alpha: Theme.current.alphaSecondaryButtonGradient), forState: .normal)
            self.setBackgroundColor(.themeJeremy, forState: .highlighted)
            self.setBackgroundColor(.themeJeremy, forState: .disabled)

            self.setBorderColor(.themeSteel20, forState: .normal)
            self.updateBorderColor()
            self.borderWidth = 1
        }

        let applySecondaryTransparentBackground = {
            self.setBackgroundColor(.clear, forState: .normal)
            self.setBackgroundColor(.themeJeremy, blendColor: UIColor(white: 1, alpha: Theme.current.alphaSecondaryButtonGradient), forState: .selected)
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

            setBackgroundColor(.themeLightGray, blendColor: UIColor.themeLight.withAlphaComponent(1), forState: .normal)
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

            cornerRadius = 14

            applySecondaryTransparentBackground()

            setBorderColor(.themeSteel20, forState: .selected)
            updateBorderColor()
            borderWidth = 1

            setTitleColor(.themeOz, for: .normal)
            setTitleColor(.themeNina, for: .highlighted)
            setTitleColor(.themeGray50, for: .disabled)
            setTitleColor(.themeOz, for: .selected)

        case .secondaryTransparentIcon:
            applySecondary()

            cornerRadius = 14

            applySecondaryTransparentBackground()

            setBorderColor(.themeSteel20, forState: .selected)
            updateBorderColor()
            borderWidth = 1

            setTitleColor(.themeGray, for: .normal)
            setTitleColor(.themeGray50, for: .highlighted)
            setTitleColor(.themeGray50, for: .disabled)
            setTitleColor(.themeGray, for: .selected)

            semanticContentAttribute = .forceRightToLeft
            applyPrioritiesRequired()

            titleEdgeInsets = UIEdgeInsets(top: 0, left: -.margin4, bottom: 0, right: .margin4)

        case .secondaryIcon:
            applySecondary()
            applySecondaryBackground()

            cornerRadius = 4

            applyPrioritiesRequired()

        case .tertiary:
            applySecondary()

            cornerRadius = 12

            setBackgroundColor(.themeLawrence, forState: .normal)
            setBackgroundColor(.themeLawrence, forState: .highlighted)
            setBackgroundColor(.themeLawrence, forState: .disabled)
            setBackgroundColor(.themeYellowD, forState: .selected)

            setTitleColor(.themeNina, for: .normal)
            setTitleColor(.themeGray50, for: .highlighted)
            setTitleColor(.themeGray50, for: .disabled)
            setTitleColor(.black, for: .selected)
        }

        return self
    }

    @discardableResult public func apply(secondaryIconImage: UIImage?) -> Self {
        setImageTintColor(.themeLeah, for: .normal)
        setImageTintColor(.themeLeah, for: .highlighted)
        setImageTintColor(.themeGray50, for: .disabled)

        setImage(secondaryIconImage?.tinted(with: .themeLeah), for: .normal)

        return self
    }

}

extension ThemeButton {

    private static func contentEdgeInsets(for style: ThemeButtonStyle) -> UIEdgeInsets {
        switch style {
        case .primaryYellow, .primaryGreen, .primaryRed, .primaryGray, .primaryTransparent: return UIEdgeInsets(top: 15, left: .margin2x, bottom: 15, right: .margin2x)
        case .secondaryDefault, .secondaryTransparent: return UIEdgeInsets(top: 5.5, left: .margin4x, bottom: 5.5, right: .margin4x)
        case .secondaryTransparentIcon: return UIEdgeInsets(top: 5.5, left: .margin16 + .margin4, bottom: 5.5, right: .margin8)
        case .tertiary: return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        case .secondaryIcon: return UIEdgeInsets(top: .margin1x, left: .margin1x, bottom: .margin1x, right: .margin1x)
        }
    }

    private static func titleFont(for style: ThemeButtonStyle) -> UIFont {
        switch style {
        case .primaryYellow, .primaryGreen, .primaryRed, .primaryGray, .primaryTransparent: return .headline2
        case .secondaryDefault, .secondaryTransparent, .secondaryTransparentIcon: return .subhead1
        case .tertiary: return .captionSB
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

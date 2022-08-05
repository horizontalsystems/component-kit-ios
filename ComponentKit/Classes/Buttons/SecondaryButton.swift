import UIKit
import ThemeKit
import SnapKit

open class SecondaryButton: UIButton {
    public static let height: CGFloat = 28
    private static let titleFont: UIFont = .subhead1
    private static let horizontalPadding: CGFloat = .margin16

    public init() {
        super.init(frame: .zero)

        cornerRadius = Self.height / 2
        layer.cornerCurve = .continuous
        semanticContentAttribute = .forceRightToLeft

        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .horizontal)
        titleLabel?.font = Self.titleFont

        syncInsets()

        snp.makeConstraints { maker in
            maker.height.equalTo(Self.height)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(image: UIImage?) {
        setImage(image?.withTintColor(.themeGray), for: .normal)
        setImage(image?.withTintColor(.themeGray), for: .highlighted)
        setImage(image?.withTintColor(.themeGray50), for: .disabled)
        setImage(image?.withTintColor(.themeDark), for: .selected)
        setImage(image?.withTintColor(.themeDark), for: [.selected, .highlighted])

        syncInsets()
    }

    public func syncInsets() {
        if image(for: .normal) != nil {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -.margin4, bottom: 0, right: .margin4)
            contentEdgeInsets = UIEdgeInsets(top: .margin4, left: .margin16 + .margin4, bottom: .margin4, right: .margin8)
        } else {
            titleEdgeInsets = .zero
            contentEdgeInsets = UIEdgeInsets(top: 0, left: Self.horizontalPadding, bottom: 0, right: Self.horizontalPadding)
        }
    }

    public func set(style: Style) {
        switch style {
        case .default:
            setBackgroundColor(.themeSteel20, for: .normal)
            setBackgroundColor(.themeSteel10, for: .highlighted)
            setBackgroundColor(.themeSteel20, for: .disabled)
            setBackgroundColor(.themeYellowD, for: .selected)
            setBackgroundColor(.themeYellow50, for: [.selected, .highlighted])
        case .transparent:
            setBackgroundColor(.clear, for: .normal)
            setBackgroundColor(.clear, for: .highlighted)
            setBackgroundColor(.clear, for: .disabled)
            setBackgroundColor(.themeYellowD, for: .selected)
            setBackgroundColor(.themeYellow50, for: [.selected, .highlighted])
        case .tab:
            setBackgroundColor(.clear, for: .normal)
            setBackgroundColor(.clear, for: .highlighted)
            setBackgroundColor(.clear, for: .disabled)
            setBackgroundColor(.clear, for: .selected)
            setBackgroundColor(.clear, for: [.selected, .highlighted])
        }

        switch style {
        case .default, .transparent:
            setTitleColor(.themeLeah, for: .normal)
            setTitleColor(.themeGray, for: .highlighted)
            setTitleColor(.themeGray50, for: .disabled)
            setTitleColor(.themeDark, for: .selected)
            setTitleColor(.themeDark, for: [.selected, .highlighted])
        case .tab:
            setTitleColor(.themeGray, for: .normal)
            setTitleColor(.themeGray, for: .highlighted)
            setTitleColor(.themeGray50, for: .disabled)
            setTitleColor(.themeLeah, for: .selected)
            setTitleColor(.themeLeah, for: [.selected, .highlighted])
        }
    }

    public enum Style {
        case `default`
        case transparent
        case tab
    }

}

extension SecondaryButton {

    public static func width(title: String) -> CGFloat {
        title.size(containerWidth: .greatestFiniteMagnitude, font: titleFont).width + 2 * horizontalPadding
    }

}


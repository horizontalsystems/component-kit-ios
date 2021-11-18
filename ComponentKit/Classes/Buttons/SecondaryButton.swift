import UIKit
import ThemeKit
import SnapKit

public class SecondaryButton: UIButton {

    public init() {
        super.init(frame: .zero)

        cornerRadius = 14
        semanticContentAttribute = .forceRightToLeft

        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .horizontal)
        titleLabel?.font = .subhead1

        syncInsets()

        setTitleColor(.themeOz, for: .normal)
        setTitleColor(.themeGray, for: .highlighted)
        setTitleColor(.themeGray50, for: .disabled)
        setTitleColor(.themeClaude, for: .selected)
        setTitleColor(.themeClaude, for: [.selected, .highlighted])

        setBackgroundColor(.themeYellowD, for: .selected)
        setBackgroundColor(.themeYellow50, for: [.selected, .highlighted])

        snp.makeConstraints { maker in
            maker.height.equalTo(28)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(image: UIImage?) {
        setImage(image?.withTintColor(.themeGray), for: .normal)
        setImage(image?.withTintColor(.themeGray50), for: .disabled)
        setImage(image?.withTintColor(.themeClaude), for: .selected)
        setImage(image?.withTintColor(.themeClaude), for: [.selected, .highlighted])

        syncInsets()
    }

    private func syncInsets() {
        if image(for: .normal) != nil {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -.margin4, bottom: 0, right: .margin4)
            contentEdgeInsets = UIEdgeInsets(top: .margin4, left: .margin16 + .margin4, bottom: .margin4, right: .margin8)
        } else {
            titleEdgeInsets = .zero
            contentEdgeInsets = UIEdgeInsets(top: 0, left: .margin16, bottom: 0, right: .margin16)
        }
    }

    public func set(style: Style) {
        switch style {
        case .default:
            setBackgroundColor(.themeSteel20, for: .normal)
            setBackgroundColor(.themeSteel20, for: .highlighted)
            setBackgroundColor(.themeSteel20, for: .disabled)
        case .transparent:
            setBackgroundColor(.clear, for: .normal)
            setBackgroundColor(.clear, for: .highlighted)
            setBackgroundColor(.clear, for: .disabled)
        }
    }

    public enum Style {
        case `default`
        case transparent
    }

}

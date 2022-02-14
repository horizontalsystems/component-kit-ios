import UIKit
import SnapKit

public class BadgeView: UIView {
    static private let sideMargin: CGFloat = .margin4

    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        snp.makeConstraints { maker in
            maker.height.equalTo(0)
        }

        layer.cornerRadius = .cornerRadius1x

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(Self.sideMargin)
            maker.centerY.equalToSuperview()
        }

        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
    }

    public func set(style: Style) {
        backgroundColor = style.backgroundColor
        label.textColor = style.textColor
        label.font = style.font

        snp.updateConstraints { maker in
            maker.height.equalTo(style.height)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var compressionResistance: UILayoutPriority = .required {
        didSet {
            label.setContentCompressionResistancePriority(compressionResistance, for: .horizontal)
        }
    }

    public var font: UIFont {
        get { label.font }
        set { label.font = newValue }
    }

    public var textColor: UIColor {
        get { label.textColor }
        set { label.textColor = newValue }
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    static public func width(for text: String, style: Style) -> CGFloat {
        text.size(containerWidth: .greatestFiniteMagnitude, font: style.font).width + sideMargin * 2
    }

}

extension BadgeView {

    public enum Style {
        case small
        case medium

        var height: CGFloat {
            switch self {
            case .small: return 15
            case .medium: return 18
            }
        }

        var font: UIFont {
            switch self {
            case .small: return .microSB
            case .medium: return .captionSB
            }
        }

        var textColor: UIColor {
            switch self {
            case .small: return .themeBran
            case .medium: return .themeWhite
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .small: return .themeJeremy
            case .medium: return .themeLucian
            }
        }

    }

}

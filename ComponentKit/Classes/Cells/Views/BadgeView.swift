import UIKit
import SnapKit

public class BadgeView: UIView {
    static private let sideMargin: CGFloat = .margin1x
    static private let height: CGFloat = 15
    static private let font: UIFont = .microSB

    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        snp.makeConstraints { maker in
            maker.height.equalTo(Self.height)
        }

        layer.cornerRadius = .cornerRadius1x
        backgroundColor = .themeJeremy

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(Self.sideMargin)
            maker.centerY.equalToSuperview()
        }

        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .themeBran
        label.font = Self.font
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

    static public func width(for text: String) -> CGFloat {
        text.size(containerWidth: .greatestFiniteMagnitude, font: font).width + sideMargin * 2
    }

}

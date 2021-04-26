import UIKit
import SnapKit

public class BadgeView: UIView {
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        snp.makeConstraints { maker in
            maker.height.equalTo(15)
        }

        layer.cornerRadius = .cornerRadius1x
        backgroundColor = .themeJeremy

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin1x)
            maker.centerY.equalToSuperview()
        }

        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .themeGray
        label.font = .microSB
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

}

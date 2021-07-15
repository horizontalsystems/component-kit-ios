import UIKit
import SnapKit

open class Right2View: UIView {
    private let label = UILabel()
    private let disclosureImageView = UIImageView(image: ComponentKit.image(named: "arrow_big_forward_20")?.withRenderingMode(.alwaysTemplate))

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = .subhead1
        label.textColor = .themeGray

        addSubview(disclosureImageView)
        disclosureImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(label.snp.trailing).offset(CGFloat.margin6)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        disclosureImageView.tintColor = .themeGray
        disclosureImageView.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }

    public var textColor: UIColor {
        get {
            label.textColor
        }
        set {
            label.textColor = newValue
        }
    }

    public var disclosureImageTintColor: UIColor? {
        get {
            disclosureImageView.tintColor
        }
        set {
            disclosureImageView.tintColor = newValue
        }
    }

}

import UIKit
import SnapKit

open class Right2View: UIView {
    private let label = UILabel()
    private let disclosureImageView = UIImageView(image: ThemeKit.image(named: "Disclosure Indicator")?.withRenderingMode(.alwaysTemplate))

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = .subhead1

        addSubview(disclosureImageView)
        disclosureImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(label.snp.trailing).offset(CGFloat.margin2x)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        disclosureImageView.tintColor = .themeGray
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

}

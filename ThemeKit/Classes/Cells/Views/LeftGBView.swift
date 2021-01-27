import UIKit
import SnapKit

open class LeftGBView: UIView {
    private let imageView = UIImageView()
    private let topLabel = UILabel()
    private let badgeView = BadgeView()
    private let bottomLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin16)
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
        }

        topLabel.font = .body
        topLabel.textColor = .themeOz

        addSubview(badgeView)
        badgeView.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin16)
            maker.top.equalTo(topLabel.snp.bottom).offset(CGFloat.margin6)
        }

        badgeView.font = .microSB

        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(badgeView.snp.trailing).offset(CGFloat.margin8)
            maker.trailing.equalToSuperview()
            maker.centerY.equalTo(badgeView)
        }

        bottomLabel.font = .subhead2
        bottomLabel.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var badgeText: String? {
        get { badgeView.text }
        set { badgeView.text = newValue }
    }

    public var badgeTextColor: UIColor {
        get { badgeView.textColor }
        set { badgeView.textColor = newValue }
    }

    public var badgeBackgroundColor: UIColor? {
        get { badgeView.backgroundColor }
        set { badgeView.backgroundColor = newValue }
    }

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

}

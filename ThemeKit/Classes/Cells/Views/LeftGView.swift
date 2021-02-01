import UIKit
import SnapKit

open class LeftGView: UIView {
    private let imageView = UIImageView()
    private let topLabel = UILabel()
    private let stackView = UIStackView()
    private let leftBadgeView = BadgeView()
    private let bottomLabel = UILabel()
    private let rightBadgeView = BadgeView()

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

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.equalTo(topLabel.snp.leading)
            maker.top.equalTo(topLabel.snp.bottom).offset(5)
            maker.trailing.equalToSuperview()
        }

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = .margin8

        stackView.addArrangedSubview(leftBadgeView)
        leftBadgeView.isHidden = true
        leftBadgeView.font = .microSB

        stackView.addArrangedSubview(bottomLabel)
        bottomLabel.font = .subhead2
        bottomLabel.textColor = .themeGray

        stackView.addArrangedSubview(rightBadgeView)
        rightBadgeView.isHidden = true
        rightBadgeView.font = .microSB

        stackView.addArrangedSubview(UIView())
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

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

    public var leftBadgeText: String? {
        get { leftBadgeView.text }
        set {
            leftBadgeView.text = newValue
            leftBadgeView.isHidden = newValue == nil
        }
    }

    public var leftBadgeTextColor: UIColor {
        get { leftBadgeView.textColor }
        set { leftBadgeView.textColor = newValue }
    }

    public var leftBadgeBackgroundColor: UIColor? {
        get { leftBadgeView.backgroundColor }
        set { leftBadgeView.backgroundColor = newValue }
    }

    public var rightBadgeText: String? {
        get { rightBadgeView.text }
        set {
            rightBadgeView.text = newValue
            rightBadgeView.isHidden = newValue == nil
        }
    }

    public var rightBadgeTextColor: UIColor {
        get { rightBadgeView.textColor }
        set { rightBadgeView.textColor = newValue }
    }

    public var rightBadgeBackgroundColor: UIColor? {
        get { rightBadgeView.backgroundColor }
        set { rightBadgeView.backgroundColor = newValue }
    }

}

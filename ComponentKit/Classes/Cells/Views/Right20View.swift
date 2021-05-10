import UIKit
import SnapKit

open class Right20View: UIView {
    private let badgeView = BadgeView()
    private let imageView = UIImageView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(badgeView)
        badgeView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        badgeView.font = .microSB
        badgeView.textColor = .themeOz

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalTo(badgeView.snp.trailing).offset(CGFloat.margin6)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        imageView.tintColor = .themeGray
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get { badgeView.text }
        set { badgeView.text = newValue }
    }

    public var textColor: UIColor {
        get { badgeView.textColor }
        set { badgeView.textColor = newValue }
    }

    public var badgeColor: UIColor? {
        get { badgeView.backgroundColor }
        set { badgeView.backgroundColor = newValue }
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var imageTintColor: UIColor? {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

}

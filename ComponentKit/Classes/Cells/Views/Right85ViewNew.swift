import UIKit
import SnapKit
import ThemeKit

open class Right85ViewNew: UIView {
    private let rightButton = ThemeButton()
    private let leftButton = ThemeButton()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(rightButton)
        rightButton.snp.makeConstraints { maker in
            maker.trailing.centerY.equalToSuperview()
        }

        rightButton.apply(style: .secondaryIcon)
        rightButton.addTarget(self, action: #selector(onTapRightButton), for: .touchUpInside)
        rightButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightButton.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(leftButton)
        leftButton.snp.makeConstraints { maker in
            maker.trailing.equalTo(rightButton.snp.leading).offset(-CGFloat.margin16)
            maker.leading.centerY.equalToSuperview()
        }

        leftButton.apply(style: .secondaryIcon)
        leftButton.addTarget(self, action: #selector(onTapLeftButton), for: .touchUpInside)
        leftButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        leftButton.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var leftImage: UIImage? {
        didSet {
            leftButton.setImage(leftImage, for: .normal)
        }
    }

    public var rightImage: UIImage? {
        didSet {
            rightButton.setImage(rightImage, for: .normal)
        }
    }

    @objc private func onTapLeftButton() {
        onTapLeft?()
    }

    public var onTapLeft: (() -> ())? {
        didSet {
            leftButton.isUserInteractionEnabled = onTapLeft != nil
        }
    }

    @objc private func onTapRightButton() {
        onTapRight?()
    }

    public var onTapRight: (() -> ())? {
        didSet {
            rightButton.isUserInteractionEnabled = onTapRight != nil
        }
    }

}

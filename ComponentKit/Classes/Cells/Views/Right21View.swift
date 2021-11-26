import UIKit
import SnapKit

open class Right21View: UIView {
    private let toggleView = UISwitch()
    private let button = UIButton()

    public var onToggle: ((Bool) -> ())?
    public var onTap: (() -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(toggleView)
        toggleView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        toggleView.setContentCompressionResistancePriority(.required, for: .horizontal)
        toggleView.tintColor = .themeSteel20
        toggleView.onTintColor = .themeYellowD
        toggleView.addTarget(self, action: #selector(onSwitch), for: .valueChanged)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.leading.top.bottom.equalToSuperview()
            maker.trailing.equalTo(toggleView.snp.leading).offset(-CGFloat.margin16)
            maker.width.equalTo(0)
        }

        button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onSwitch() {
        onToggle?(toggleView.isOn)
    }

    @objc private func onTapButton() {
        onTap?()
    }

    public var isOn: Bool {
        get { toggleView.isOn }
        set { toggleView.isOn = newValue }
    }

    public var buttonImage: UIImage? {
        get { button.image(for: .normal) }
        set {
            button.setImage(newValue, for: .normal)

            button.snp.remakeConstraints { maker in
                maker.leading.top.bottom.equalToSuperview()
                maker.trailing.equalTo(toggleView.snp.leading).offset(newValue == nil ? -CGFloat.margin16 : 0)
                maker.width.equalTo(newValue == nil ? 0 : 20 + CGFloat.margin16 * 2)
            }
        }
    }

    public func set(isOn: Bool, animated: Bool) {
        toggleView.setOn(isOn, animated: animated)
    }

}

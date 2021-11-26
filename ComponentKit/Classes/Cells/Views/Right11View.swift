import UIKit
import SnapKit

open class Right11View: UIView {
    private let imageView = UIImageView()
    private let toggleView = UISwitch()

    public var onToggle: ((Bool) -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        addSubview(toggleView)
        toggleView.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin8)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        toggleView.setContentCompressionResistancePriority(.required, for: .horizontal)
        toggleView.tintColor = .themeSteel20
        toggleView.onTintColor = .themeYellowD
        toggleView.addTarget(self, action: #selector(onSwitch), for: .valueChanged)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onSwitch() {
        onToggle?(toggleView.isOn)
    }

    public var isOn: Bool {
        get { toggleView.isOn }
        set { toggleView.isOn = newValue }
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var imageTintColor: UIColor? {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

    public func set(isOn: Bool, animated: Bool) {
        toggleView.setOn(isOn, animated: animated)
    }

}

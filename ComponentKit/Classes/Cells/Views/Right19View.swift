import UIKit
import SnapKit

open class Right19View: UIView {
    private let imageView = UIImageView()
    private let button = UIButton()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.top.trailing.bottom.equalToSuperview()
        }

        button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: .margin16, bottom: 0, right: .margin16)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.trailing.equalTo(button.snp.leading)
            maker.centerY.equalToSuperview()
            maker.size.equalTo(0)
        }

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapButton() {
        onTap?()
    }

    public var onTap: (() -> ())?

    public var buttonImage: UIImage? {
        get { button.image(for: .normal) }
        set { button.setImage(newValue, for: .normal) }
    }

    public var image: UIImage? {
        get { imageView.image }
        set {
            imageView.image = newValue

            imageView.snp.remakeConstraints { maker in
                maker.leading.equalToSuperview().inset(newValue == nil ? 0 : CGFloat.margin16)
                maker.trailing.equalTo(button.snp.leading).offset(newValue == nil ? 0 : CGFloat.margin4)
                maker.centerY.equalToSuperview()
                maker.size.equalTo(newValue == nil ? 0 : 20)
            }
        }
    }

    public var imageTintColor: UIColor? {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

}

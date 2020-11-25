import UIKit
import SnapKit

open class LeftAView: UIView {
    private let imageView = UIImageView()
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin4x)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = .body
        label.textColor = .themeOz
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

}

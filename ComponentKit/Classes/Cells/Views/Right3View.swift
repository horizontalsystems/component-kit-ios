import UIKit
import SnapKit

open class Right3View: UIView {
    private let imageView = UIImageView()
    private let disclosureImageView = UIImageView(image: ComponentKit.image(named: "arrow_big_forward_20")?.withRenderingMode(.alwaysTemplate))

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(disclosureImageView)
        disclosureImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin6)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        disclosureImageView.tintColor = .themeGray
        disclosureImageView.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

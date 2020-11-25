import UIKit
import SnapKit

open class Right3View: UIView {
    private let imageView = UIImageView()
    private let disclosureImageView = UIImageView(image: ThemeKit.image(named: "disclosure_indicator_20")?.withRenderingMode(.alwaysTemplate))

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        addSubview(disclosureImageView)
        disclosureImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin6)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        disclosureImageView.tintColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

}

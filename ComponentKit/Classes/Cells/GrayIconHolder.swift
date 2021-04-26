import UIKit
import SnapKit

open class GrayIconHolder: UIView {
    private let coinIconImageView = UIImageView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        snp.makeConstraints { maker in
            maker.width.height.equalTo(44)
        }

        backgroundColor = .themeJeremy
        cornerRadius = .cornerRadius2x

        addSubview(coinIconImageView)
        coinIconImageView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }

        coinIconImageView.tintColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    public func bind(image: UIImage?) {
        if let image = image {
            coinIconImageView.image = image.withRenderingMode(.alwaysTemplate)
            coinIconImageView.isHidden = false
        } else {
            coinIconImageView.isHidden = true
        }
    }

}

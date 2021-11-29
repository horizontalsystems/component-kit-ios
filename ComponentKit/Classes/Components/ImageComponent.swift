import UIKit
import SnapKit
import Kingfisher

public class ImageComponent: UIView {
    public let imageView = UIImageView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setImage(urlString: String?, placeholder: UIImage?) {
        imageView.image = placeholder

        if let urlString = urlString, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url, placeholder: placeholder)
        }
    }

}

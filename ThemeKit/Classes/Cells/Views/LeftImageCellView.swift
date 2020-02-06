import UIKit
import SnapKit

open class LeftImageCellView: UIView {
    private let imageView = UIImageView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(CGFloat.margin4x)
            maker.trailing.equalToSuperview()
            maker.size.equalTo(24)
        }

        imageView.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(image: UIImage?) {
        imageView.image = image
    }

}

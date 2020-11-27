import UIKit
import SnapKit

open class DropdownCellView: UIView {
    private let imageView = UIImageView(image: ThemeKit.image(named: "arrow_small_down_20"))

    override public init(frame: CGRect) {
        super.init(frame: frame)

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().inset(CGFloat.margin4x)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

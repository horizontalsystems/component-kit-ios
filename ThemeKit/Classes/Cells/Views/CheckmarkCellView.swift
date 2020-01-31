import UIKit
import SnapKit

open class CheckmarkCellView: UIView {
    private let imageView = UIImageView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        imageView.image = ThemeKit.image(named: "Checkmark 24")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .themeJacob
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-CGFloat.margin4x)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func bind(visible: Bool) {
        imageView.isHidden = !visible
    }

}

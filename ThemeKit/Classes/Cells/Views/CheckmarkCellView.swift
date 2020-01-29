import UIKit
import SnapKit

class CheckmarkCellView: UIView {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.image = ThemeKitBundle.shared.image(named: "Checkmark 24")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .themeJacob
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-CGFloat.margin4x)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(visible: Bool) {
        imageView.isHidden = !visible
    }

}

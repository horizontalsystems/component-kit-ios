import UIKit
import SnapKit

open class LeftBView: UIView {
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = .body
        label.textColor = .themeOz
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var textColor: UIColor {
        get { label.textColor }
        set { label.textColor = newValue }
    }

}

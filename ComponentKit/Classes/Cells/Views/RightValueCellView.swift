import UIKit
import SnapKit

open class RightValueCellView: UIView {
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        label.font = .subhead1
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.top.bottom.equalToSuperview()
            maker.trailing.equalToSuperview().inset(CGFloat.margin2x)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(text: String?, highlighted: Bool = false) {
        label.text = text
        label.textColor = highlighted ? .themeOz : .themeGray
    }

}

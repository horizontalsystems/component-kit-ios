import UIKit
import SnapKit

open class SingleLineCellView: UIView {
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        label.font = .body
        label.textColor = .themeOz

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin4x)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(text: String?) {
        label.text = text
    }

}

import UIKit
import SnapKit

open class Right7View: UIView {
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.lineBreakMode = .byTruncatingMiddle
        label.font = .subhead1
        label.textColor = .themeLeah
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

    public var italic: Bool {
        get { label.font == .subhead1I }
        set { label.font = newValue ? .subhead1I : .subhead1 }
    }

}

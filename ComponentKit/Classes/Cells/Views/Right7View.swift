import UIKit
import SnapKit

open class Right7View: UIView {
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        label.textAlignment = .right
        label.lineBreakMode = .byTruncatingMiddle
        label.font = Self.font(italic: false)
        label.textColor = .themeLeah
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
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
        set { label.font = Self.font(italic: newValue) }
    }

}

extension Right7View {

    private static func font(italic: Bool) -> UIFont {
        italic ? .subhead1I : .subhead1
    }

}

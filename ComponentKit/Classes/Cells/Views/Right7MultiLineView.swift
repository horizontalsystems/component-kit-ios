import UIKit
import SnapKit

open class Right7MultiLineView: UIView {
    private static let insets = UIEdgeInsets(top: 14, left: 0, bottom: 13, right: 0)

    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = Self.font(italic: false)
        label.textColor = .themeLeah
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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

extension Right7MultiLineView {

    private static func font(italic: Bool) -> UIFont {
        italic ? .subhead1I : .subhead1
    }

    public static func height(containerWidth: CGFloat, text: String?, italic: Bool = false) -> CGFloat {
        let text = text ?? ""
        let textHeight = text.height(forContainerWidth: containerWidth, font: Right7MultiLineView.font(italic: italic))
        return textHeight + insets.height
    }

}

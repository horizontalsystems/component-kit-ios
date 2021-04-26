import UIKit
import SnapKit

open class Right7View: UIView {
    private static let insets = UIEdgeInsets(top: 14, left: 0, bottom: 13, right: 0)

    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(Self.insets)
        }

        label.lineBreakMode = .byTruncatingMiddle
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = Self.font(italic: false)
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
        set { label.font = Self.font(italic: newValue) }
    }

}

extension Right7View {

    private static func font(italic: Bool) -> UIFont {
        italic ? .subhead1I : .subhead1
    }

    public static func height(containerWidth: CGFloat, text: String?, italic: Bool = false) -> CGFloat {
        let text = text ?? ""
        let textHeight = text.height(forContainerWidth: containerWidth, font: font(italic: italic))
        return textHeight + insets.height
    }

}

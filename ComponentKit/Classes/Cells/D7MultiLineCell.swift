import UIKit
import SnapKit

open class D7MultiLineCell: BaseThemeCell {
    private let leftView = LeftDView()
    private let rightView = Right7MultiLineView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        get { leftView.text }
        set { leftView.text = newValue }
    }

    public var value: String? {
        get { rightView.text }
        set { rightView.text = newValue }
    }

    public var valueColor: UIColor {
        get { rightView.textColor }
        set { rightView.textColor = newValue }
    }

    public var valueItalic: Bool {
        get { rightView.italic }
        set { rightView.italic = newValue }
    }

}

extension D7MultiLineCell {

    public static func height(containerWidth: CGFloat, backgroundStyle: BackgroundStyle, title: String, value: String?, valueItalic: Bool = false) -> CGFloat {
        let titleWidth = LeftDView.width(text: title)
        let valueWidth = containerWidth - Self.margin(backgroundStyle: backgroundStyle).width - titleWidth - Self.leftInset - Self.middleInset - Self.rightInset
        return Right7MultiLineView.height(containerWidth: valueWidth, text: value, italic: valueItalic)
    }

}
